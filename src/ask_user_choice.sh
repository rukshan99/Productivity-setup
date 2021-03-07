#!/bin/sh
source src/hardcoded_variables.txt

get_user_input() {

	# read incoming arguments
	test_all=$1
	
	software_install_categories=read_categories
	supported_software_packages=read_supported_software_packages $software_install_categories
	
	if [ "$test_all" = "--all" ]; then
		write_installation_list $supported_software_packages
	else
		user_choice=prompt_user_choice $supported_software_packages
		write_installation_list $supported_software_packages
	fi
}

read_categories() {
	echo $(awk '/installationType:/ {print $2}' $SUPPORTED_SOFTWARE_LIST_LOCATION)
}

read_supported_software_packages() {
	installation_type=$1
	echo $(awk '/'$installation_type'/ {print $2}' $SUPPORTED_SOFTWARE_LIST_LOCATION)
}

prompt_user_choice() {
	echo "hello world"
	# TODO: ask verification of correctness of list to user.
}

write_installation_list() {
	echo "hello world"
}
