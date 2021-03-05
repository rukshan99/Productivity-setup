#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source src/hardcoded_variables.txt
mkdir -p src/logs

setup() {

	# make main code runnable
	chmod +x src/install_git.sh
	
	# specify output location of log file for this command
	LOG_PATH_APT_UPDATE=$LOG_LOCATION"apt_update.txt"
	LOG_PATH_INSTALL_GIT=$LOG_LOCATION"install_git.txt"
	
	# Remove old log files if exist
	if [ -f "$LOG_PATH_APT_UPDATE" ] ; then
	    rm "$LOG_PATH_APT_UPDATE"
	fi
	
	# Remove old log files if exist
	if [ -f "$LOG_PATH_INSTALL_GIT" ] ; then
	    rm "$LOG_PATH_INSTALL_GIT"
	fi

	# load the functions from the instal shell file
	. ./src/install_git.sh --source-only
	
	# run the function that updates apt
	run apt_update $LOG_PATH_APT_UPDATE
	
	# run the function that installs git
	run apt_install_git $LOG_PATH_APT_INSTALL_GIT
}


@test "running the apt update function in file: /src/git_install.sh." {
	LOG_ENDING=$(tail -c 67 $LOG_PATH_APT_UPDATE)
	EXPECTED_OUTPUT="packages can be upgraded. Run 'apt list --upgradable' to see them."
		
	assert_equal "$LOG_ENDING" "$EXPECTED_OUTPUT"
	#assert_output "$EXPECTED_OUTPUT"
}

@test "running the apt install git function in file: /src/git_install.sh." {
	LOG_ENDING=$(tail -c 67 $LOG_PATH_APT_INSTALL_GIT)
	EXPECTED_OUTPUT="packages can be upgraded. Run 'apt list --upgradable' to see them."
		
	assert_equal "$LOG_ENDING" "$EXPECTED_OUTPUT"
	#assert_output "$EXPECTED_OUTPUT"
}
