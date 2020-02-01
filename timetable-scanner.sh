#!/bin/bash

__ScriptVersion="1.0"

function usage () {
    echo "Usage :  $0 [options] [file(s)]

    Options:
    -h|help       Display this message
    -v|version    Display script version

    Files:
    Insert files as arguements, and it will generate a database for the Managebac-timetable script.
    "
}

while getopts ":hv" opt
do
  case $opt in

    h|help     )  usage; exit 0   ;;

    v|version  )  echo "$0 -- Version $__ScriptVersion"; exit 0   ;;

    * )  echo -e "\n  Option does not exist : $OPTARG\n"
          usage; exit 1   ;;

  esac    # --- end of case ---
done
shift $(($OPTIND-1))

# Finding Classes
for (( i = 1; i < $# + 1; i++ )); do
    echo Processing ${!i}...

    grep class-name "$f" | cut -d'>' -f3 | sed 's/<\/a//' | rev | cut -d' ' -f2,3,4,5,6,7 | rev | sed 's/JoB//' | sed 's/YH//' > data$i

    grep '<th>' "$f" | sed 's/<th>//' | sed 's/<\/th>//' | sed 's/Period//'| sed 's/,//' >> data$i 

    # Put classes in the right order
    printf '%s\n' 6m1 11m2 16m3 9m5 13m6 17m7 12m9 15m10 18m11 15m13 17m14 19m15 w q | ed -s data$i

    # Put the dates in the right order
    printf '%s\n' 22m0 23m5 24m10 25m15 26m20 26d w q | ed -s data$i
done

echo Cleaning Up
cat data* > sheet
sed -i 's/[ \t]*$//' "sheet"
sed -i '$!N;$!N;$!N;$!N;s/\n/,/g' "sheet"
