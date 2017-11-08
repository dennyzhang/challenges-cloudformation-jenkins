#!/bin/bash -ex
function current_git_sha() {
    set -e
    local src_dir=${1?}
    cd "$src_dir"
    sha=$(git log -n 1 | head -n 1 | grep commit | awk -F' ' '{print $2}')
    echo "$sha"
}

function git_log() {
    echo "check log at dir: $code_dir"
    local code_dir=${1?}
    local tail_count=${2:-"10"}
    cd "$code_dir"
    command="git log -n $tail_count --pretty=format:\"%h - %an, %ar : %s\""
    echo -e "\nShow latest git commits: $command"
    eval "$command"
    echo -e "\n"
}

function git_update_code() {
    set -e
    local branch_name=${1?}
    local working_dir=${2?}
    local git_repo_url=${3?}

    local git_repo
    git_repo=$(echo "${git_repo_url%.git}" | awk -F '/' '{print $2}')

    local code_dir="$working_dir/$branch_name/$git_repo"
    echo "Git update code for $git_repo_url to $code_dir"
    # checkout code, if absent
    if [ ! -d "$working_dir/$branch_name/$git_repo" ]; then
        mkdir -p "$working_dir/$branch_name"
        cd "$working_dir/$branch_name"
        git clone --depth 1 "$git_repo_url" --branch "$branch_name" --single-branch
        cd "$code_dir"
        git tag -l
        git config user.email "jenkins@devops.com"
        git config user.name "Jenkins Auto"
    else
        cd "$code_dir"
        git tag -l
        git config remote.origin.url "$git_repo_url"
        git config user.email "jenkins@devops.com"
        git config user.name "Jenkins Auto"
        # add retry for network turbulence
        git pull origin "$branch_name" || (sleep 2 && git pull origin "$branch_name")
    fi

    cd "$code_dir"
    git checkout "$branch_name"
    # git reset --hard
}

function copy_to_reposerver() {
    # Upload Packages to local apache vhost
    local git_repo=${1?}
    local branch_name=${2?}
    local code_dir=${3?}
    local files_to_copy=${4?}
    cd "$code_dir"

    local repo_dir="/var/www/repo"
    local repo_link="$repo_dir/$branch_name"

    [ -d "$repo_link" ] || mkdir -p "$repo_link"
    for f in $files_to_copy; do
        if [[ "$f" == "$git_repo/"* ]]; then
            cp "$f" "$repo_link/"
        fi
    done
}

flag_file="$HOME/$JOB_NAME.flag"

function shell_exit() {
    errorcode=$?

    echo -e "\n\nShow latest commits for TOTVS/mdm"
    git_log "$code_dir"

    echo -e "\n\nShow latest commits for TOTVS/totvslabs-framework"
    git_log "$framework_code_dir"
    if [ $errorcode -eq 0 ]; then
        echo "OK"> "$flag_file"
    else
        echo "ERROR"> "$flag_file"
        exit 1
    fi
}
###############################################################################
. /etc/profile
# Build Repo
github_repo=$(echo "${git_repo_url%.git}" | awk -F '/' '{print $2}')
code_dir="$working_dir/$app_branch_name/$github_repo"

framework_github_repo=$(echo "${framework_git_repo_url%.git}" | awk -F '/' '{print $2}')
framework_code_dir="$working_dir/$framework_branch_name/$framework_github_repo"

trap shell_exit SIGHUP SIGINT SIGTERM 0

if $clean_start; then
    export clean_fe_build=true
    [ ! -d "$framework_code_dir" ] || rm -rf "$framework_code_dir"
    [ ! -d "$code_dir" ] || rm -rf "$code_dir"
    rm -rf ~/.m2/repository
fi

if [ ! -d "$working_dir" ]; then
    mkdir -p "$working_dir"
    chown -R jenkins:jenkins "$working_dir"
fi

if [ -d "$code_dir" ]; then
    old_sha=$(current_git_sha "$code_dir")
else
    old_sha=""
fi

# Update code
git_update_code "$framework_branch_name" "$working_dir" "$framework_git_repo_url"
git_update_code "$app_branch_name" "$working_dir" "$git_repo_url"

new_sha=$(current_git_sha "$code_dir")
echo "old_sha: $old_sha, new_sha: $new_sha"
if ! $force_build; then
    if [ "$old_sha" = "$new_sha" ]; then
        echo "No new commit, since previous build"
        if [ -f "$flag_file" ] && [[ $(cat "$flag_file") = "ERROR" ]]; then
            echo "Previous build has failed"
            exit 1
        else
            exit 0
        fi
    fi
fi

echo "================= Build Environment ================="
env
echo -e "\n\n\n"

cd "$framework_code_dir"
export framework_code_dir="$framework_code_dir"
make

cd "$code_dir"
export code_dir="$code_dir"
make

# Generate build version
version_file="$working_dir/$app_branch_name/$github_repo/build_version"
build_time="$(date +'%Y-%m-%d %H:%M:%S')"

my_ip=$(/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')

cd "$working_dir/$app_branch_name/$github_repo"
mdm_repo_revision="$(git rev-parse HEAD)"
cd "$working_dir/$framework_branch_name/$framework_github_repo"
framework_repo_revision="$(git rev-parse HEAD)"

cat > "$version_file" << EOF
Build From $github_repo($app_branch_name branch).
Revision: $mdm_repo_revision
Build From $framework_github_repo($framework_branch_name branch).
Revision: $framework_repo_revision
Build Time: $build_time
Jenkins Job: ${JOB_NAME}:${BUILD_DISPLAY_NAME} on $my_ip
EOF

if [ -n "$files_to_copy" ]; then
    echo "================= Copy built Packages ================="
    # copy mdm
    copy_to_reposerver "$github_repo" "$app_branch_name" "$working_dir/$app_branch_name" "$files_to_copy"
    # copy framework
    copy_to_reposerver "$framework_github_repo" "$framework_branch_name" "$working_dir/$framework_branch_name" "$files_to_copy"
    echo "Display cksum"
    ls -lth "/var/www/repo/$app_branch_name"
    cksum "/var/www/repo/$app_branch_name"/* >> "$version_file"
fi

[ -n "$old_build_retention_days" ] || old_build_retention_days=7
echo "================= Remove old backkup older than $old_build_retention_days ================="
touch "$working_dir/$framework_branch_name/$framework_github_repo"
touch "$working_dir/$app_branch_name/$github_repo"

find /var/www/repo -maxdepth 1 -name "[1-9]+\.[1-9]+" -type d -mtime "+$old_build_retention_days" -exec rm -rf '{}' +
find "$working_dir" -mindepth 2 -maxdepth 2 -type d -mtime "+$old_build_retention_days" -exec rm -rf {} +
