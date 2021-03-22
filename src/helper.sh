#!/bin/bash
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
	source ./$SCRIPT_PATH $LOG_PATH
}

execute_files() {
	filenames_without_extension=("$@")
	
	# Loop through files that perform commands
	for i in "${filenames_without_extension[@]}"
	do
		# run main functions that perform some commands
		run_main_functions "$i"
	done
}

write_to_log() {

	# read incoming arguments
	dest_dir=$1
	dest_file=$2
	dest_path=$dest_dir$dest_file
	
	shift # eat first argument
	shift # eat second argument
	
	# create empty file (overwrite previous content if it exists)
	> $dest_path
	
	# append remaining args to file
	for i in "$*"; do
		cat <<< "$i" >> $dest_path
	done
}

append_to_log() {
	echo ""
}

remove_logs() {
	rm -r src/logs/*
}

remove_log_file() {
	log_filename=$1
	rm -r src/logs/$log_filename
}
remove_log_file "$@"

create_log_file() {
	log_filename=$1
	log_dirname=$2
	mkdir -p $log_dirname
	touch src/logs/$log_filename
}

read_user_key_from_log() {
	value=$(<src/logs/D_26_add_user_to_taskserver.txt)
	RESULT=${value:14:36}
	echo $RESULT
}
