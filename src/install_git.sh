#!/bin/sh
install_git() {
	LOG_PATH=$1
	update=$(sudo apt update)
	echo $update > $LOG_PATH
	echo $update
}
install_git "$@"
