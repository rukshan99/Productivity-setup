#!/bin/bash
. src/hardcoded_variables.txt
. src/ask_user_choice.sh
. src/install_user_choice.sh

function run_some_test() {
	./test/libs/bats/bin/bats test/test_install_git_postsetup.bats
}

# get list of all possible installation types and pass it to the prompt.
function run_prompt_user_choice() {
	supported_installation_categories=$(read_categories "supported")
	selected_software_packages=$(prompt_user_choice $supported_installation_categories)
	
	echo "The selected_software_packages are:"
	echo $selected_software_packages
	
	# install selected packages.
	$(install_user_choices)
	
	# test selected packages.
	test_user_choice_installation "true"
	#run_some_test
	
	# TODO: verify installation of selected packages
	# Run the github test file manually
	#./test/libs/bats/bin/bats test/test_install_git_postsetup.bats
}
run_prompt_user_choice "$@"
