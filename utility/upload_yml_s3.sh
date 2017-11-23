#!/usr/bin/env bash
##-------------------------------------------------------------------
## @copyright 2017 DennyZhang.com
## Licensed under MIT 
##   https://www.dennyzhang.com/wp-content/mit_license.txt
##
## File: upload_yml_s3.sh
## Author : Denny <https://www.dennyzhang.com/contact>
## Description :
## --
## Created : <2017-11-15>
## Updated: Time-stamp: <2017-11-23 08:14:12>
##-------------------------------------------------------------------
set -e

working_dir=${1:-"../"}
s3_bucket_name=${2:-"aws.dennyzhang.com"}

#cd "$working_dir"

while IFS= read -r -d '' file
do
    short_fname=$(basename "$file")
    echo "upload $file to https://s3.amazonaws.com/${s3_bucket_name}/${short_fname}"
    s3cmd put "$file" "s3://${s3_bucket_name}/$short_fname"
done <   <(find "$working_dir" -name "cf-jenkins*.yml" -print0)
## File: upload_yml_s3.sh ends
