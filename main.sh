source src/hardcoded_variables.txt
# read hardcoded variables
SOURCEDIR=$PWD

# get installation dependent parameters
LINUX_USERNAME=$(whoami)
LINUX_GROUP=$(whoami)
echo $LINUX_USERNAME

# function to swap entire line in file that contains a substring
function swapline_containing_string {
  local OLD_LINE_PATTERN=$1; shift
  local NEW_LINE=$1; shift
  local FILE=$1
  local NEW=$(echo "${NEW_LINE}" | sed 's/\//\\\//g')
  touch "${FILE}"
  sed -i '/'"${OLD_LINE_PATTERN}"'/{s/.*/'"${NEW}"'/;h};${x;/./{x;q100};x}' "${FILE}"
  if [[ $? -ne 100 ]] && [[ ${NEW_LINE} != '' ]]
  then
    echo "${NEW_LINE}" >> "${FILE}"
  fi
}

