#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

#source test/helper.sh
source src/hardcoded_variables.txt
source src/ask_user_choice.sh
mkdir -p src/logs

# Makes the main script runnable, removes the log file and runs bash script that is tested.
run_main_functions() {
	local SCRIPT_NAME=$1	
	SCRIPT_PATH=src/"$SCRIPT_NAME".sh
	local LOG_PATH=$LOG_LOCATION"$SCRIPT_NAME".txt
	
	chmod +x $SCRIPT_PATH
	
	# Remove old log files if exist
	if [ -f "$LOG_PATH" ] ; then
	    rm "$LOG_PATH"
	fi
	
	# run the function that updates apt
	run ./$SCRIPT_PATH $LOG_PATH
}

# Method that executes all tested main code before running tests.
setup() {
	
	# Declare filenames of files that perform commands
	declare -a arr=("ask_user_choice"
        )
                	
	# Loop through files that perform commands
	for i in "${arr[@]}"
	do
		# run main functions that perform some commands
		run_main_functions "$i"
	done
}


@test "Verify the categories are read correctly." {
	actual_result=$(read_categories)
	actual_results=($actual_result) # convert single string to list
        expected_results=("apt" "snap" "custom" "needUserInput" "deviceDependent")
	
	for i in "${!expected_results[@]}"; do
	    assert_equal "${actual_results[i]}" "${expected_results[i]}"
	done
}

@test "Verify the supported_software_packages are read correctly for category: apt." {
	tested_category="apt:"
	actual_result=$(read_supported_software_packages $tested_category)
	actual_results=($actual_result) # convert single string to list
        expected_results=("git")
	
	for i in "${!expected_results[@]}"; do
	    assert_equal "${actual_results[i]}" "${expected_results[i]}"
	done
}

@test "Verify the supported_software_packages are read correctly for category: snap." {
	tested_category="snap:"
	actual_result=$(read_supported_software_packages $tested_category)
	actual_results=($actual_result) # convert single string to list
        expected_results=("")
	
	for i in "${!expected_results[@]}"; do
	    assert_equal "${actual_results[i]}" "${expected_results[i]}"
	done
}

@test "Verify the supported_software_packages are read correctly for category: custom." {
	tested_category="custom:"
	actual_result=$(read_supported_software_packages $tested_category)
	actual_results=($actual_result) # convert single string to list
        expected_results=("")
	
	for i in "${!expected_results[@]}"; do
	    assert_equal "${actual_results[i]}" "${expected_results[i]}"
	done
}

@test "Verify the supported_software_packages are read correctly for category: needUserInput." {
	tested_category="needUserInput:"
	actual_result=$(read_supported_software_packages $tested_category)
	actual_results=($actual_result) # convert single string to list
        expected_results=("")
	
	for i in "${!expected_results[@]}"; do
	    assert_equal "${actual_results[i]}" "${expected_results[i]}"
	done
}

@test "Verify the supported_software_packages are read correctly for category: deviceDependent." {
	tested_category="deviceDependent:"
	actual_result=$(read_supported_software_packages $tested_category)
	actual_results=($actual_result) # convert single string to list
        expected_results=("")
	
	for i in "${!expected_results[@]}"; do
	    assert_equal "${actual_results[i]}" "${expected_results[i]}"
	done
}
