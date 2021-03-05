# read hardcoded variables
SOURCEDIR=$PWD
source src/hardcoded_variables.txt

# get installation dependent parameters
LINUX_USERNAME=$(whoami)
LINUX_GROUP=$(whoami)
echo $LINUX_USERNAME
IP=$(hostname -f)
echo $IP
