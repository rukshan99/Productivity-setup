#!/bin/bash
. src/helper.sh

# Declare filenames of files that perform commands to install github
install_github() {
	
	# Declare filenames of files that perform commands
	declare -a arr=("0_apt_update"
                "1_apt_upgrade"
                "2_apt_install_git"
                )
                	
	# Loop through files that perform commands
	for i in "${arr[@]}"
	do
		# run main functions that perform some commands
		run_main_functions "$i"
	done
}

test_github() {
	./test/libs/bats/bin/bats test/post_install/test_install_git_postsetup.bats
}
