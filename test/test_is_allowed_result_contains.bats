#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source test/helper.sh

@test "Tests if actual_result_contains_any_allowed_result method returns false if the actual result does not contain any of the allowed/expected results." {
	ACTUAL_RESULT="The center target string is: this is an output, and this tail is just a filler."
	ALLOWED_RESULTS=(
		"a different output"
		"another different output"
    		"an extra different output"
	)
	TEST_RESULT=$(actual_result_contains_any_allowed_result "$ACTUAL_RESULT" "${ALLOWED_RESULTS[@]}")
	assert_equal $(echo -n $TEST_RESULT | tail -c 5) "false"
}

@test "Tests if actual_result_contains_any_allowed_result method returns true if the actual result contains the first list element of the allowed/expected results." {
	ACTUAL_RESULT="The center target string is: this is an output, and this tail is just a filler."
	ALLOWED_RESULTS=(
		"this is an output"
		"a different output"
		"another different output"
    		"an extra different output"
	)
	TEST_RESULT=$(actual_result_contains_any_allowed_result "$ACTUAL_RESULT" "${ALLOWED_RESULTS[@]}")
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
}

@test "Tests if actual_result_contains_any_allowed_result method returns true if the actual result contains the second list element of the allowed/expected results." {
	ACTUAL_RESULT="The center target string is: this is an output, and this tail is just a filler."
	ALLOWED_RESULTS=(
		"a different output"
		"this is an output"
		"another different output"
    		"an extra different output"
	)
	TEST_RESULT=$(actual_result_contains_any_allowed_result "$ACTUAL_RESULT" "${ALLOWED_RESULTS[@]}")
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
}

@test "Tests if actual_result_contains_any_allowed_result method returns true if the actual result contains the third list element of the allowed/expected results." {
	ACTUAL_RESULT="The center target string is: this is an output, and this tail is just a filler."
	ALLOWED_RESULTS=(
		"a different output"
		"another different output"
    		"this is an output"
    		"an extra different output"
	)
	TEST_RESULT=$(actual_result_contains_any_allowed_result "$ACTUAL_RESULT" "${ALLOWED_RESULTS[@]}")
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
}

@test "Tests if actual_result_contains_any_allowed_result method returns true if the actual result contains the last list element of the allowed/expected results." {
	ACTUAL_RESULT="The center target string is: this is an output, and this tail is just a filler."
	ALLOWED_RESULTS=(
		"a different output"
		"another different output"
    		"an extra different output"
    		"this is an output"
	)
	TEST_RESULT=$(actual_result_contains_any_allowed_result "$ACTUAL_RESULT" "${ALLOWED_RESULTS[@]}")
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
}

@test "Tests if actual_result_contains_any_allowed_result method returns true if the actual result contains the second and last list element of the allowed/expected results." {
	ACTUAL_RESULT="The center target string is: this is an output, and this tail is just a filler."
	ALLOWED_RESULTS=(
		"a different output"
		"this is an output"
		"another different output"
    		"an extra different output"
    		"this is an output"
	)
	TEST_RESULT=$(actual_result_contains_any_allowed_result "$ACTUAL_RESULT" "${ALLOWED_RESULTS[@]}")
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
}

@test "Tests if actual_result_contains_any_allowed_result method returns false if only the actual result is passed without passing expected results." {
	ACTUAL_RESULT="The center target string is: this is an output, and this tail is just a filler."
	TEST_RESULT=$(actual_result_contains_any_allowed_result "$ACTUAL_RESULT")
	assert_equal $(echo -n $TEST_RESULT | tail -c 5) "false"
}
