#!/bin/bash
. src/hardcoded_variables.txt
. src/ask_user_choice.sh



function install_selected_software_packages() {
	echo "hello world"
}

# get list of all possible installation types and pass it to the prompt.
function run_prompt_user_choice() {
	supported_installation_categories=$(read_categories "supported")
	selected_software_packages=$(prompt_user_choice $supported_installation_categories)
	
	echo "The selected_software_packages are:"
	echo $selected_software_packages
	
	# install selected packages.
	$(install_user_choices)
	
	# TODO: verify installation of selected packages
}
run_prompt_user_choice "$@"
