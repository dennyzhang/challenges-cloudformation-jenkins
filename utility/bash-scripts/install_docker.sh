#!/usr/bin/env bash
##-------------------------------------------------------------------
## @copyright 2017 DennyZhang.com
## Licensed under MIT 
##   https://www.dennyzhang.com/wp-content/mit_license.txt
##
## File: install_docker.sh
## Author : Denny <https://www.dennyzhang.com/contact>
## Description :
## --
## Created : <2017-11-14>
## Updated: Time-stamp: <2017-11-14 09:00:04>
##-------------------------------------------------------------------
set -e
if ! which docker; then
    # TODO: install specific version
    echo "Install docker daemon"
    wget -qO- https://get.docker.com/ | sh
fi
## File: install_docker.sh ends
