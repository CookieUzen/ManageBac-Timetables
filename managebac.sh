#!/bin/bash

# Fetching ManageBac html file
cd ~/managebac #&& rm *
# bash "$HOME/scripts/save_page_as" -b firefox "swis.managebac.cn/student/timetables?start_date=`date +\"%Y-%m-%d\"`"        

# Finding Classes
grep class-name This\ Week.html | cut -d'>' -f3 | sed 's/<\/a//' | rev | cut -d' ' -f2,3,4,5,6,7 | rev | sed 's/JoB//' | sed 's/YH//' > this\ week

printf '%s\n' 6m1 11m2 16m3 9m5 13m6 17m7 12m9 15m10 18m11 15m13 17m14 19m15 w q | ed -s this\ week

grep class-name Next\ Week.html | cut -d'>' -f3 | sed 's/<\/a//' | rev | cut -d' ' -f2,3,4,5,6,7 | rev | sed 's/JoB//' | sed 's/YH//' > next\ week

printf '%s\n' 6m1 11m2 16m3 9m5 13m6 17m7 12m9 15m10 18m11 15m13 17m14 19m15 w q | ed -s next\ week

grep class-name Previous\ Week.html | cut -d'>' -f3 | sed 's/<\/a//' | rev | cut -d' ' -f2,3,4,5,6,7 | rev | sed 's/JoB//' | sed 's/YH//' > previous\ week

printf '%s\n' 6m1 11m2 16m3 9m5 13m6 17m7 12m9 15m10 18m11 15m13 17m14 19m15 w q | ed -s previous\ week