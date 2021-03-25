#!/bin/bash
source src/hardcoded_variables.txt

source src/apt_autokey_gtk.sh
source src/apt_github.sh
source src/apt_signal.sh
source src/snap_anki.sh

install_user_choices() {
	selected_software_packages=($(read_software_packages "selected")) # outer brackets to store as list
	
	# loop through selected packages
	for i in "${!selected_software_packages[@]}"; do
		if [ "${selected_software_packages[i]}" == anki ]; then
			$(install_anki) # install user choice: anki
		elif [ "${selected_software_packages[i]}" == autokey-gtk ]; then
			$(install_autokey_gtk) # install user choice: autokey_gtk
		elif [ "${selected_software_packages[i]}" == github ]; then
			$(install_github) # install user choice: github
		elif [ "${selected_software_packages[i]}" == signal ]; then
			$(install_signal) # install user choice: signal
		fi
	done
}

test_user_choice_installation() {
	selected_software_packages=($(read_software_packages "selected")) # outer brackets to store as list
	
	# loop through selected packages
	for i in "${!selected_software_packages[@]}"; do
		if [ "${selected_software_packages[i]}" == anki ]; then
			test_anki
		elif [ "${selected_software_packages[i]}" == autokey-gtk ]; then
			test_autokey_gtk
		elif [ "${selected_software_packages[i]}" == github ]; then
			test_github
		elif [ "${selected_software_packages[i]}" == signal ]; then
			test_signal
		fi
	done
}
