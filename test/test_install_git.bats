#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source src/hardcoded_variables.txt

mkdir -p src/logs

@test "running the file in /src/git_install.sh." {
	chmod +x src/install_git.sh
	LOG_PATH=$LOG_LOCATION"/install_git.txt"
	run ./src/install_git.sh $LOG_PATH
	LOG_ENDING=$(tail -c 67 $LOG_PATH)
	EXPECTED_OUTPUT="packages can be upgraded. Run 'apt list --upgradable' to see them."
		
	assert_equal "$LOG_ENDING" "$EXPECTED_OUTPUT"
}
