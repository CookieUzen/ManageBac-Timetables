#/bin/bash

# Variables
datasheet="$HOME/.config/managebac/sheet"
__ScriptVersion="2.0"

# Functions
function usage () {
    echo "
  Usage :  $0 [options] [commands]
  Options:
  -h    | Display this message
  -v    | Display script version
  -m    | Display manual/README of this program

  -n    | Set the date to today's classes
  -t    | Set the date to tomorrow's classes
  -y    | Set the date to yesterday's classes
  -a    | Set the date to classes in +/-days
  -d    | Set the date to classes at date
  -r    | Set the date to classes at a range of dates (seperated by '~')
  -s    | Scan a ManageBac HTML file to generate a database of classes

  Commands:
  show  | Show Timetables for a certain day
  find  | Find all occurances of a certain class
  set   | update database
    "
}

function manual() {
    echo "
# ManageBac-Timetables
This is a tiny bash script (less than 160 lines of code) that pulls the classes timetable off ManageBac into a text file. Then, script provides easy access and searching through the classes.

## Installation
To install the program, run the install.sh file.

## Database
First, we have to create a database for the upcomming classes in order for the program to work.  
Open your managebac page on any web browser, then save the website. Save the website in HTML format, then run:
    timetable-scannner file1 file2 file3 ...
Where the files represent your managebac html files. 

## Usage
After we have successfully created a database for and program, we can run the managebac script.
  
The script works on a principle of flags and commands. With the flags specifying a date, and the command performing an action.
  
For Example:
  timetable -a +10 show
This command will show the timetable classes of classes 10 days later.
  
For more information, read the help page:
timetable -h

    " | less
}

function fetch() { 
    # ManageBac Date
    for (( i = 0; i < ${#cdate[@]}; i++ )); do
        mdate=("${mdate[@]}" "$(date --date="${cdate[i]}" +"%B %d")")

        line=$(grep "${mdate[i]}" "$datasheet")
        c1=("${c1[@]}" "$(echo $line | cut -d',' -f2)")
        c2=("${c2[@]}" "$(echo $line | cut -d',' -f3)")
        c3=("${c3[@]}" "$(echo $line | cut -d',' -f4)")
        c4=("${c4[@]}" "$(echo $line | cut -d',' -f5)")
        
        [[ -z ${c1[i]} ]] && c1[i]="None"
        [[ -z ${c2[i]} ]] && c2[i]="None"
        [[ -z ${c3[i]} ]] && c3[i]="None"
        [[ -z ${c4[i]} ]] && c4[i]="None"
    done
}

function show() {
    fetch
    for (( i = 0; i < ${#mdate[@]}; i++ )); do
        echo "${mdate[i]}'s classes are:"
        echo ${c1[i]}
        echo ${c2[i]}
        echo ${c3[i]}
        echo ${c4[i]}
        echo
    done
}

function find() {
    for (( i = 0; i < ${#cdate[@]}; i++ )); do
        mdate=("${mdate[@]}" "$(date --date="${cdate[i]}" +"%B %d")")
        line=$(grep "${mdate[i]}" "$datasheet")
    done
    
    echo ${lines[@]}

}

function set() {
    # Fetching ManageBac html file
    cd "$HOME"/.config/managebac

    # Finding Classes
    for f in ManageBac*.html
    do
        echo Processing $f...

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
}

# Handling Flags
while getopts ":hnvd:a:tyr:m" opt; do
  case $opt in

    h)
        usage; exit 0
        ;;

    v)
        echo "$0 -- Version $__ScriptVersion"; exit 0  
        ;;

    a)
        cdate=("${cdate[@]}" "$(date --date="$OPTARG days" +"%Y-%m-%d")")
        ;;

    d)
        cdate=("${cdate[@]}" "$(date --date="$OPTARG" +"%Y-%m-%d")")
        ;;

    y)
        cdate=("${cdate[@]}" "$(date --date="yesterday" +"%Y-%m-%d")")
        ;;

    t)
        cdate=("${cdate[@]}" "$(date --date="tomorrow" +"%Y-%m-%d")")
        ;;
    n)
        cdate=("${cdate[@]}" "$(date --date="today" +"%Y-%m-%d")")
        ;;
    r)
        ddate=$(date --date="$(echo "$OPTARG" | cut -d'~' -f1)" +"%Y-%m-%d")
          end=$(date --date="$(echo "$OPTARG" | cut -d'~' -f2)" +"%Y-%m-%d")

        while [[ "$ddate" != "$end" ]]; do
            list=("${list[@]}" "$ddate")
            ddate=$(date --date="$ddate +1day" +"%Y-%m-%d")
        done

        cdate=("${cdate[@]}" "${list[@]}")
        ;;

    m)
        manual
        ;;

    * ) 
        echo -e "\n    Option does not exist : -$OPTARG" 
        usage; exit 1
        ;;

  esac
done
shift $(($OPTIND-1))

# Handling Commands
for (( i = 1; i < $# + 1; i++ )); do
    case ${!i} in
        show)   show ;;
        help)   usage; exit 0 ;;
        find)   find ;;
        set)    set ;;
    esac
done
