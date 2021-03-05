#!/bin/sh
apt_update() {
	local LOG_PATH=$1
	update=$(sudo apt update)
	echo $update > $LOG_PATH
}
apt_update "$@"

apt_install_git() {
	local LOG_PATH=$1
	update=$(yes | sudo apt install git)
	echo $update > $LOG_PATH
}
apt_install_git "$@"
