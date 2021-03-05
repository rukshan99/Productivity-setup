#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source src/hardcoded_variables.txt

mkdir -p src/logs

setup() {

	# make main code runnable
	chmod +x src/install_git.sh
	
	# specify output location of log file for this command
	LOG_PATH=$LOG_LOCATION"install_git.txt"
	
	# Remove old log files if exist
	if [ -f "$LOG_PATH" ] ; then
	    rm "$LOG_PATH"
	fi

	# run the function that installs git
	run ./src/install_git.sh $LOG_PATH
}

@test "running the file in /src/git_install.sh." {
	LOG_ENDING=$(tail -c 67 $LOG_PATH)
	EXPECTED_OUTPUT="packages can be upgraded. Run 'apt list --upgradable' to see them."
		
	assert_equal "$LOG_ENDING" "$EXPECTED_OUTPUT"
}
