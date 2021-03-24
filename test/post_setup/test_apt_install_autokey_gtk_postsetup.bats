#!./test/libs/bats/bin/bats

load '../../test/libs/bats-support/load'
load '../../test/libs/bats-assert/load'

source src/hardcoded_variables.txt
source test/helper.sh

@test "running the apt update function in some file and verifying log output." {
	LOG_CONTENT=$(cat $LOG_LOCATION"apt_0_update.txt")
        ALLOWED_RESULTS=("Reading package lists... Building dependency tree... Reading state information... All packages are up to date."
        	"packages can be upgraded. Run 'apt list --upgradable' to see them."
        )
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_tail "$LOG_CONTENT" "${ALLOWED_RESULTS[@]}")
	
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
}

@test "running the apt upgrade function in some file and verifying log output." {
	LOG_ENDING=$(tail -c 11 $LOG_LOCATION"apt_1_upgrade.txt")
	EXPECTED_OUTPUT=" upgraded."
		
	assert_equal "$LOG_ENDING" "$EXPECTED_OUTPUT"
}

@test "running the apt install autokey_gtk function in some file and verifying log output." {
	LOG_ENDING=$(head -c 115 $LOG_LOCATION"apt_2_install_autokey_gtk.txt")
	EXPECTED_OUTPUT="Reading package lists... Building dependency tree... Reading state information... autokey_gtk is already the newest version"
		
	assert_equal "$LOG_ENDING" "$EXPECTED_OUTPUT"
}

@test "Checking autokey_gtk version response." {
	COMMAND_OUTPUT=$(autokey_gtk --version)
	EXPECTED_OUTPUT="autokey_gtk version 2."
		
	ALLOWED_RESULTS=("autokey_gtk version 2."
        	"autokey_gtk version 3."
        	"autokey_gtk version 4."
        	"autokey_gtk version 5."
        	"autokey_gtk version 6."
        	"autokey_gtk version 7."
        	"autokey_gtk version 8."
        	"autokey_gtk version 9."
        )
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$COMMAND_OUTPUT" "${ALLOWED_RESULTS[@]}")
	
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
}
