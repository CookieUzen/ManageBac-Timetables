#!/bin/bash
# sudo cp timetable.sh /usr/bin/timetable
sudo cp timetable-scanner.sh /usr/bin/timetable-scanner

cd "$HOME"/.config/
if !([[ -e managebac ]]); then
    mkdir -p managebac
fi
