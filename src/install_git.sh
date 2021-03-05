#!/bin/sh
install_git() {
	LOG_LOCATION=$1
	LOG_PATH=$1"/install_git.txt"
	update=$(sudo apt update)
	echo $update > $LOG_PATH
	echo "done"
}
install_git "$@"
