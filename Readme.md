# What is this? [![Build Status](https://travis-ci.org/a-t-0/Taskwarrior-installation.svg?branch=refactor_to_shell)](https://travis-ci.org/a-t-0/Taskwarrior-installation)
This is a thoroughly tested set of bash scripts that automatically install an opinonated student/developer setup on Ubuntu 20.04 with an **emphasis** on productivity and focus. It empowers the user to select actively which information the user wants to consume by fencing off undesired digital tempations. It is opinionated in the sence that it blocks all social media, youtube, image searches, news sites and adult content. Not because I think they are bad, instead it is because I am highly passionate about the opportunities that I am given and I want to give those opportunities and pursuits my complete dedication.

## Usage: Installation (Currently only testing works)
Install git and download this repository:
```
sudo apt update
yes | sudo apt install git
git clone https://github.com/HiveMinds-EU/Productivity-setup
```
Run the main code from the root of this repository with:
```
./main.sh
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
./test.sh
```
Note: Put your unit test files (with extention .bats) in folder: `/test/`


## Functionality
Unit tests bash code/scripts and provides continuous integration testing through Travis CI. Intended to be built as a two-line command that sets up a laptop for productivity right after a clean Ubuntu image installation.
