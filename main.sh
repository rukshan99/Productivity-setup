#!/bin/bash
. src/hardcoded_variables.txt
. src/ask_user_choice.sh

# get list of all possible installation types and pass it to the prompt.

function run_prompt_user_choice() {
	supported_installation_categories=$(read_categories "supported")
	prompt_user_choice $supported_installation_categories	
}
run_prompt_user_choice "$@"
