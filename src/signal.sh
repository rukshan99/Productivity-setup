#!/bin/bash
#. src/helper.sh
#source src/helper.sh
# Declare filenames of files that perform commands to install github
install_signal() {
	
	# Declare filenames of files that perform commands
	declare -a arr=("3_1_apt_install_signal"
                "3_2_apt_install_signal"
                "0_apt_update"
                "3_4_apt_install_signal"
                )

	# Loop through files that perform commands
	for i in "${arr[@]}"
	do
		# run main functions that perform some commands
		run_main_functions "$i"
	done
}

test_signal() {
	./test/libs/bats/bin/bats test/post_setup/test_install_signal_postsetup.bats
}
