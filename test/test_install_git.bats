#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source src/hardcoded_variables.txt

@test "running the file in /src/git_install.sh." {
	chmod +x src/install_git.sh
	run ./src/install_git.sh $LOG_LOCATION
	assert_output 42
}
