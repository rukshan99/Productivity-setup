#!/bin/sh
apt_update() {
	local LOG_PATH=$1
	update=$(sudo apt update)
	echo "DID A TEST" > "TEMP.txt"
	echo $update > $LOG_PATH
}
apt_update "$@"
