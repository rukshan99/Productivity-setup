#!/bin/sh
install_git() {
	local LOG_PATH=$1
	local update=$(sudo apt update)
	echo $update > $LOG_PATH
	echo $update
}
install_git "$@"
