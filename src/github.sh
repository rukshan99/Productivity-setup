#!/bin/sh
# Declare filenames of files that perform commands to install github
declare -a commands=("0_apt_update"
        "1_apt_upgrade"
        "2_apt_install_git"
        )      	
$(execute_files $commands)
