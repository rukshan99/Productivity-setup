#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source test/helper.sh

@test "assert the right string is not in the tail of the left string." {
	left="Right hand string"
	right="Some string"
	TEST_RESULT=$(right_is_in_tail_of_left "$left" "$right")
	assert_equal $(echo -n $TEST_RESULT | tail -c 5) "false"
}

@test "assert the right string is in the tail of the left string." {
	left="Right hand string Some string"
	right="Some string"
	TEST_RESULT=$(right_is_in_tail_of_left "$left" "$right")
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
}

@test "assert the right string is not in the head of the left string." {
	left="Right hand string"
	right="Some string"
	allowed_size=${#right}
	TEST_RESULT=$(right_is_in_tail_of_left "$left" "$right")
	assert_equal $(echo -n $TEST_RESULT | tail -c 5) "false"
}

@test "assert the right string is in the head of the right left." {
	left="Some string Right hand string"
	right="Some string"
	allowed_size=${#right}
	TEST_RESULT=$(right_is_in_head_of_left "$left" "$right")
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
}

@test "Test if equality function returns false on unequal input." {
	left="Some string"
	right="Different string"
	TEST_RESULT=$(equal_strings "$left" "$right")
	assert_equal $(echo -n $TEST_RESULT | tail -c 5) "false"
}

@test "Test if equality function returns false on unequally capitalized input." {
	left="Some string"
	right="some string"
	TEST_RESULT=$(equal_strings "$left" "$right")
	assert_equal $(echo -n $TEST_RESULT | tail -c 5) "false"
}

@test "Test if equality function returns true on equal input." {
	left="Some string"
	right="Some string"
	TEST_RESULT=$(equal_strings "$left" "$right")
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
}
