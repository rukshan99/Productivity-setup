#!/bin/sh
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
	touch src/logs/$log_filename
}

read_user_key_from_log() {
	value=$(<src/logs/D_26_add_user_to_taskserver.txt)
	RESULT=${value:14:36}
	echo $RESULT
}
