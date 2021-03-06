#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source test/helper.sh

@test "Write tests that pass it an actual result and a list with expected results that do not occur in the actual result and assert the function returns false." {
	ACTUAL_RESULT="this is an output with the expected output at the head"
	ALLOWED_RESULTS=(
		"a different output"
		"another different output"
    		"an extra different output"
	)
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$ACTUAL_RESULT" "${ALLOWED_RESULTS[@]}")
	assert_equal $(echo -n $TEST_RESULT | tail -c 5) "false"
}

@test "Write tests that pass it `this is an output` and a list that contains it in the first entry and assert the function returns true." {
	ACTUAL_RESULT="this is an output with the expected output at the head"
	ALLOWED_RESULTS=(
		"this is an output"
		"a different output"
		"another different output"
    		"an extra different output"
	)
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$ACTUAL_RESULT" "${ALLOWED_RESULTS[@]}")
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
}

@test "Write tests that pass it `this is an output` and a list that contains it in the first middle entry and assert the function returns true." {
	ACTUAL_RESULT="this is an output with the expected output at the head"
	ALLOWED_RESULTS=(
		"a different output"
		"this is an output"
		"another different output"
    		"an extra different output"
	)
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$ACTUAL_RESULT" "${ALLOWED_RESULTS[@]}")
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
}

@test "Write tests that pass it `this is an output` and a list that contains it in the other middle entry and assert the function returns true." {
	ACTUAL_RESULT="this is an output with the expected output at the head"
	ALLOWED_RESULTS=(
		"a different output"
		"another different output"
    		"this is an output"
    		"an extra different output"
	)
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$ACTUAL_RESULT" "${ALLOWED_RESULTS[@]}")
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
}

@test "Write tests that pass it `this is an output` and a list that contains it in last entry and assert the function returns true." {
	ACTUAL_RESULT="this is an output with the expected output at the head"
	ALLOWED_RESULTS=(
		"a different output"
		"another different output"
    		"an extra different output"
    		"this is an output"
	)
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$ACTUAL_RESULT" "${ALLOWED_RESULTS[@]}")
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
}

@test "Write tests that pass it `this is an output` and a list that does contains it twice and assert the function returns true." {
	ACTUAL_RESULT="this is an output with the expected output at the head"
	ALLOWED_RESULTS=(
		"a different output"
		"this is an output"
		"another different output"
    		"an extra different output"
    		"this is an output"
	)
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$ACTUAL_RESULT" "${ALLOWED_RESULTS[@]}")
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
}

@test "Write tests that pass it `this is an output` without a list and assert the function returns false." {
	ACTUAL_RESULT="this is an output with the expected output at the head"
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$ACTUAL_RESULT")
	assert_equal $(echo -n $TEST_RESULT | tail -c 5) "false"
}
