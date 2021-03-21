# unit tested shell code template [![Build Status](https://travis-ci.org/a-t-0/Taskwarrior-installation.svg?branch=refactor_to_shell)](https://travis-ci.org/a-t-0/Taskwarrior-installation)

## Usage: Installation (Currently only testing works)
Install git and download this repository:
```
sudo apt update
yes | sudo apt install git
git clone https://github.com/HiveMinds-EU/Productivity-setup
```
Run the main code from the root of this repository with:
```
./src/main.sh
```
Uninstall it with:
```
./src/uninstall.sh
```


## Usage: Testing
First install the required submodules with:
```
chmod +x install-bats-libs.sh
./install-bats-libs.sh
```

Next, run the unit tests with:
```
chmod +x test.sh
sudo ./test.sh
```
Note: Put your unit test files (with extention .bats) in folder: `/test/`


## Functionality
Unit tests bash code/scripts and provides continuous integration testing through Travis CI. Intended to be built as a two-line command that sets up a laptop for productivity right after a clean Ubuntu image installation.
