#!/bin/sh
source src/hardcoded_variables.txt

get_user_input() {

	# read incoming arguments
	test_all=$1
	
	software_install_categories=$(read_categories)
	supported_software_packages=$(read_supported_software_packages $software_install_categories)
	
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
	installation_types=("$@")
	supported_software_packages=""
	for i in "${!installation_types[@]}"; do
	    supported_software_packages+=$(read_supported_software_packages_per_category "${installation_types[i]}")" "
	done
	echo $supported_software_packages
}

read_supported_software_packages_per_category() {
	installation_type=$1
	echo $(awk '/'$installation_type':/ {print $2}' $SUPPORTED_SOFTWARE_LIST_LOCATION)
}

prompt_user_choice() {
	# clear output log
	source src/helper.sh
	$(remove_log_file $SELECTED_SOFTWARE_FILENAME)
	
	# create output log file
	$(create_log_file $SELECTED_SOFTWARE_FILENAME)

	installation_types=("$@")
	supported_software_packages=""
	selected_software_packages=""
	for i in "${!installation_types[@]}"; do
		echo "installationType: ${installation_types[i]}" >> $LOG_LOCATION$SELECTED_SOFTWARE_FILENAME
		new_software=$(read_supported_software_packages_per_category "${installation_types[i]}")
		new_software_list=($new_software)
		for j in "${!new_software_list[@]}"; do
			supported_software_packages+=${new_software_list[j]}" "
			user_input=$(ask_if_user_wants_some_software_package ${new_software_list[j]})
			if [ $(echo -n $user_input | tail -c 4) == true ]; then
		    		selected_software_packages+=${new_software_list[j]}" "
		    		echo "${installation_types[i]}: "${new_software_list[j]} >> $LOG_LOCATION$SELECTED_SOFTWARE_FILENAME
	    		fi
    		done
	done
	echo "selected_software_packages"
	echo $selected_software_packages
	
	# TODO: ask verification of correctness of list to user.
}

ask_if_user_wants_some_software_package() {
	software_package=$1
	if [ ${#software_package} -ge 1 ]; then
		while true; do
		    read -p "Do you wish to install: $software_package?" yn
		    case $yn in
			[Yy]* ) echo "true"; break;;
			[Nn]* ) echo "false"; break;;
			* ) echo "Please answer yes or no.";;
		    esac
		done
	else
		echo "false"
	fi
}

write_installation_list() {
	echo "hello world"
}
