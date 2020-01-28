#!/bin/bash
cd "$HOME/managebac"
mapfile -t now < this\ week
mapfile -t before < next\ week
mapfile -t after < previous\ week

# Colors
RESET=$(echo -en '\033[0m')
RED=$(echo -en '\033[00;31m')
BLUE=$(echo -en '\033[00;34m')

# Setting Variables
Monday=("${now[0]}" "${now[1]}" "${now[2]}" "${now[3]}")
Tuesday=("${now[4]}" "${now[5]}" "${now[6]}" "${now[7]}")
Wednesday=("${now[8]}" "${now[9]}" "${now[10]}" "${now[11]}")
Thursday=("${now[12]}" "${now[13]}" "${now[14]}" "${now[15]}")
Friday=("${now[16]}" "${now[17]}" "${now[18]}" "${now[19]}")

LMonday=("${before[0]}" "${before[1]}" "${before[2]}" "${before[3]}")
LTuesday=("${before[4]}" "${before[5]}" "${before[6]}" "${before[7]}")
LWednesday=("${before[8]}" "${before[9]}" "${before[10]}" "${before[11]}")
LThursday=("${before[12]}" "${before[13]}" "${before[14]}" "${before[15]}")
LFriday=("${before[16]}" "${before[17]}" "${before[18]}" "${before[19]}")

NMonday=("${after[0]}" "${after[1]}" "${after[2]}" "${after[3]}")
NTuesday=("${after[4]}" "${after[5]}" "${after[6]}" "${after[7]}")
NWednesday=("${after[8]}" "${after[9]}" "${after[10]}" "${after[11]}")
NThursday=("${after[12]}" "${after[13]}" "${after[14]}" "${after[15]}")
NFriday=("${after[16]}" "${after[17]}" "${after[18]}" "${after[19]}")

function Day() {
    for (( i = 0; i < 4; i++ ))
    do
        case $date in
            Monday)
            echo ${Monday[$i]}
                ;;
            Tuesday)
            echo ${Tuesday[$i]}
                ;;
            Wednesday)
            echo ${Wednesday[$i]}
                ;;
            Thursday)
            echo ${Thursday[$i]}
                ;;
            Friday)
            echo ${Friday[$i]} 
                ;;
        esac
    done
    echo
}

function Today() {
    #Prints today's timetable
    echo ${BLUE}Today\'s Classes are:${RESET} 
    date=`date +"%A"`
    Day
}

function Tomorrow() {
    echo ${BLUE}Tomorrow\'s Classes are:${RESET} 
    date=`date -d tomorrow +"%A"`
    Day
}

function Yesterday() {
    echo ${BLUE}Yesterday\'s Classes are:${RESET} 
    date=`date -d tomorrow +"%A"`
    Day
}

function Date() {
    num=${OPTARG}
    date=`date --date="$num day" +"%A"`
    echo ${BLUE}`date --date="$num day" +"%A"` \($num\) Days Later\'s Classes are:${RESET} 
    Day
}

__ScriptVersion="1.0"
function usage ()
{
    echo "Usage :  $0 [options]

    Options:
    -h|help       Display this message
    -v|version    Display script version
    -n|now        Display today's classes
    -t|tomorrow   Display tomorrow's classes
    -y|yesterday  Display yesterday's classes
    -d|date       Display classes in +days (example ./timetable.sh -d +10)
    "
}

#-----------------------------------------------------------------------
#  Handle command line arguments
#-----------------------------------------------------------------------

while getopts ":hvntyd:" opt
do
  case $opt in

    h|help      )  usage; exit 0   ;;

    v|version   )  echo "$0 -- Version $__ScriptVersion"; exit 0   ;;

    n|now       )  Today;;

    t|tomorrow  )  Tomorrow;;

    y|yesterday )  Yesterday;;

    d|date      )  Date;;

    * )  echo -e "\n  Option does not exist : $OPTARG\n"
          usage; exit 1   ;;

  esac    # --- end of case ---
done
shift $(($OPTIND-1))
