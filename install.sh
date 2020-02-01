#!/bin/bash
sudo mv timetable.sh /usr/bin/timetable
sudo mv timetable-scanner.sh /usr/bin/timetable-scanner

cd "$HOME"/.config/
if [[ -e managebac ]]; then
    mkdir -p managebac
else
    echo Managebac folder exsists, edit install.sh to suit your needs.
fi
