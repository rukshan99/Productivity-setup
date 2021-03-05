#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source src/hardcoded_variables.txt

mkdir -p src/logs

# Makes the main script runnable, removes the log file and runs main file.
run_main_functions() {
	local SCRIPT_NAME=$1	
	SCRIPT_PATH=src/"$SCRIPT_NAME".sh
	local LOG_PATH=$LOG_LOCATION"$SCRIPT_NAME".txt
	
	chmod +x $SCRIPT_PATH
	
	# Remove old log files if exist
	if [ -f "$LOG_PATH" ] ; then
	    rm "$LOG_PATH"
	fi
	
	# run the function that updates apt
	run ./$SCRIPT_PATH $LOG_PATH
}

# Method that executes all tested main code before running tests.
setup() {
	
	# Declare filenames of files that perform commands
	declare -a arr=("0_apt_update"
                "1_apt_upgrade"
                "2_apt_install_git"
                )
                	
	# Loop through files that perform commands
	for i in "${arr[@]}"
	do
		# run main functions that perform some commands
		run_main_functions "$i"
	done
}

is_allowed_result() {
	test_result=false
	actual_result=$1
	#allowed_results=$2
	shift            # Shift all arguments to the left (original $1 gets lost)
	allowed_results=("$@")
	#echo "actual_result"
	#echo "$actual_result"
	#echo "allowed_results"
	#echo "$allowed_results"
	
	for i in "${allowed_results[@]}"
	do
		allowed_size=${#i}
		echo "allowed_size"
		echo $allowed_size
		
		actual_size=${#actual_result}
		echo "actual_size"
		echo $actual_size
		
		if [ $actual_size -lt $allowed_size ]; then echo "error";
			echo "The actual size is smaller than allowed, so do nothing"
			assert_equal 6 9
		else 
			echo "SHOULD CHECK IF it equals"
			last_chars=$(echo -n $actual_result | tail -c $allowed_size)
			echo "last_chars"
			echo $last_chars
			echo "i"
			echo "$i"
			#assert_equal "$last_chars" "$i"
			
			if [ "$last_chars" = "$i" ]; then
			    echo "Strings are equal."
			    test_result=true
			else
			    echo "Strings are not equal."
			fi
		fi
		#assert_equal $actual_result $i
	done
	echo $test_result
}

@test "running the apt update function in some file." {
	#LOG_ENDING=$(tail -c 67 $LOG_LOCATION"0_apt_update.txt")
	LOG_ENDING=$(cat $LOG_LOCATION"0_apt_update.txt")
	#declare -a ALLOWED_RESULTS=("packages can be upgraded. Run 'apt list --upgradable' to see them."
        #        "Reading package lists... Building dependency tree... Reading state information... All packages are up to date."
        #        )
        ALLOWED_RESULTS=("Reading package lists... Building dependency tree... Reading state information... All packages are up to date."
        "packages can be upgraded. Run 'apt list --upgradable' to see them."
                
                )
	TEST_RESULT=$(is_allowed_result "$LOG_ENDING" "${ALLOWED_RESULTS[@]}")
	#assert_equal "$LOG_ENDING" "$ALLOWED_RESULTS"
	echo "TEST_RESULT"
	echo $TEST_RESULT
	assert_equal "true" $(echo -n $TEST_RESULT | tail -c 4)
	#assert_equal 111 222
}

@test "running the apt upgrade function in some file." {
	LOG_ENDING=$(tail -c 11 $LOG_LOCATION"1_apt_upgrade.txt")
	EXPECTED_OUTPUT=" upgraded."
		
	assert_equal "$LOG_ENDING" "$EXPECTED_OUTPUT"
}

@test "running the apt install git function in some file." {
	LOG_ENDING=$(head -c 115 $LOG_LOCATION"2_apt_install_git.txt")
	EXPECTED_OUTPUT="Reading package lists... Building dependency tree... Reading state information... git is already the newest version"
		
	assert_equal "$LOG_ENDING" "$EXPECTED_OUTPUT"
}
