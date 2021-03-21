#!/bin/bash
. src/hardcoded_variables.txt
. src/ask_user_choice.sh

function run_prompt_user_choice() {
	prompt_user_choice $(read_categories)
	#$(prompt_user_choice $(read_categories) "y y n")
}
run_prompt_user_choice "$@"
