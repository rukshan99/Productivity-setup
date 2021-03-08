#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source test/helper.sh
source src/hardcoded_variables.txt
source src/helper.sh
source src/ask_user_choice.sh

mkdir -p src/logs

# Method that executes all tested main code before running tests.
setup() {
	# TODO: create a user choice with github only
	$(create_greedy_user)
	$(install_user_choices)
}

@test "Testing greedy user choice selection is created." {
	assert $(exist $SELECTED_SOFTWARE_LIST_LOCATION)
}

@test "Testing greedy user with the apt update function in some file and verifying log output." {
	LOG_CONTENT=$(cat $LOG_LOCATION"0_apt_update.txt")
        ALLOWED_RESULTS=("Reading package lists... Building dependency tree... Reading state information... All packages are up to date."
        	"packages can be upgraded. Run 'apt list --upgradable' to see them."
        )
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_tail "$LOG_CONTENT" "${ALLOWED_RESULTS[@]}")
	assert $(exist $SELECTED_SOFTWARE_LIST_LOCATION)
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
}

@test "Testing greedy user with the apt upgrade function in some file and verifying log output." {
	LOG_ENDING=$(tail -c 11 $LOG_LOCATION"1_apt_upgrade.txt")
	EXPECTED_OUTPUT=" upgraded."
		
	assert_equal "$LOG_ENDING" "$EXPECTED_OUTPUT"
}

@test "Testing greedy user with the apt install git function in some file and verifying log output." {
	LOG_ENDING=$(head -c 115 $LOG_LOCATION"2_apt_install_git.txt")
	EXPECTED_OUTPUT="Reading package lists... Building dependency tree... Reading state information... git is already the newest version"
		
	assert_equal "$LOG_ENDING" "$EXPECTED_OUTPUT"
}
