#!./test/libs/bats/bin/bats

load '../../test/libs/bats-support/load'
load '../../test/libs/bats-assert/load'

source src/hardcoded_variables.txt
source test/helper.sh

@test "running the apt update function in some file and verifying log output." {
	LOG_CONTENT=$(cat $LOG_LOCATION"0_apt_update.txt")
        ALLOWED_RESULTS=("Reading package lists... Building dependency tree... Reading state information... All packages are up to date."
        	"packages can be upgraded. Run 'apt list --upgradable' to see them."
        )
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_tail "$LOG_CONTENT" "${ALLOWED_RESULTS[@]}")
	
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
}

@test "running the apt upgrade function in some file and verifying log output." {
	LOG_ENDING=$(tail -c 11 $LOG_LOCATION"1_apt_upgrade.txt")
	EXPECTED_OUTPUT=" upgraded."
		
	assert_equal "$LOG_ENDING" "$EXPECTED_OUTPUT"
}

@test "running the apt install git function in some file and verifying log output." {
	LOG_ENDING=$(head -c 115 $LOG_LOCATION"2_apt_install_git.txt")
	EXPECTED_OUTPUT="Reading package lists... Building dependency tree... Reading state information... git is already the newest version"
		
	assert_equal "$LOG_ENDING" "$EXPECTED_OUTPUT"
}

@test "Checking git version response." {
	COMMAND_OUTPUT=$(git --version)
	EXPECTED_OUTPUT="git version 2."
		
	ALLOWED_RESULTS=("git version 2."
        	"git version 3."
        	"git version 4."
        	"git version 5."
        	"git version 6."
        	"git version 7."
        	"git version 8."
        	"git version 9."
        )
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$COMMAND_OUTPUT" "${ALLOWED_RESULTS[@]}")
	
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
}
