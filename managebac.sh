#!/bin/bash

# Fetching ManageBac html file
cd ~/managebac #&& rm *
# bash "$HOME/scripts/save_page_as" -b firefox "swis.managebac.cn/student/timetables?start_date=`date +\"%Y-%m-%d\"`"        

# Finding Classes
i=1;
for f in ManageBac*.html
do
    echo Processing $f...

    grep class-name "$f" | cut -d'>' -f3 | sed 's/<\/a//' | rev | cut -d' ' -f2,3,4,5,6,7 | rev | sed 's/JoB//' | sed 's/YH//' > data$i

    grep '<th>' "$f" | sed 's/<th>//' | sed 's/<\/th>//' | sed 's/Period//'| sed 's/,//' >> data$i 

    printf '%s\n' 6m1 11m2 16m3 9m5 13m6 17m7 12m9 15m10 18m11 15m13 17m14 19m15 w q | ed -s data$i

    printf '%s\n' 22m0 23m5 24m10 25m15 26m20 26d w q | ed -s data$i

    let i+=1
done

echo Cleaning Up
cat data* > sheet
sed -i 's/[ \t]*$//' "sheet"
sed -i '$!N;$!N;$!N;$!N;s/\n/,/g' "sheet"
