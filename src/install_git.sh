#!/bin/sh
install_git() {
	LOG_LOCATION=$1
	update=$(sudo apt update)
	echo $update > stdout.txt
	echo "done"
}
install_git "$@"
