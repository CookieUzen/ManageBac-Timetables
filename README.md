# ManageBac-Timetables
This is a tiny bash script (less than 160 lines of code) that pulls the classes timetable off ManageBac into a text file. Then, script provides easy access and searching through the classes.

## Installation
To install the program, run the `install.sh` file.

## Database
First, we have to create a database for the upcomming classes in order for the program to work.  
*Open your managebac page on any web browser, then save the website.* Save the website in HTML format, then run:
```bash
timetable-scannner file1 file2 file3 ...
```
Where the files represent your managebac html files. 

## Usage
After we have successfully created a database for and program, we can run the managebac script.
  
The script works on a principle of flags and commands. With the flags specifying a date, and the command performing an action.
  
For Example:
```bash
timetable -a +10 show
```
This command will show the timetable classes of classes 10 days later.
  
**For more information, read the help page:**
```bash
timetable -h
```
