/*
 * =====================================================================================
 *
 *       Filename:  timetable.c
 *
 *    Description:  A timetable app 
 *
 *        Version:  2.0
 *        Created:  01/29/2020 09:00:26 AM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Uzen Huang
 *
 * =====================================================================================
 */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <getopt.h>
#include <string.h>

int date;

void version() {
    printf("Version: 2.0\n");
}

void help() {
    printf("\
Usage :timetable [options] [arguments] \n\
\n\
Options:\n\
  -h|help       Display this message\n\
  -v|version    Display script version\n\
  -t|tomorrow   Display tomorrow's classes\n\
  -y|yesterday  Display yesterday's classes \n\
  -d|date       Display classes in +days\n\
");
}

char* scan(char* input) {
    FILE * fp;
    char * line = NULL;
    size_t len = 0;
    ssize_t read;

    fp = fopen("/home/uzen/managebac/sheet", "r");
    if (fp == NULL)
        exit(EXIT_FAILURE);

    while ((read = getline(&line, &len, fp)) != -1) {
        if (strstr(line, input) == NULL) {
            return line;
        }
    }

    fclose(fp);
    if (line)
        free(line);
    exit(EXIT_SUCCESS);
}

char variables() {
    char classes[4][25] = {
        "x",
        "y",
        "z"
    }; 

    return classes;
}

void show() {

}

int main(int argc, char *argv[]) {
        int opt; 
      
    while((opt = getopt(argc, argv, ":hvntyd:")) != -1) {  
        switch(opt) {  
            case 'v':  
                version();
                break;
            case 'h':  
                help();
                break;  
            case 't':
                break;
            case 'y':
                break;
            case 'd':  
                printf(scan("Feburary 20"));
                break;  
            case ':':  
                printf("option needs a value\n");  
                break;  
            case '?':  
                printf("unknown option: %c\n", optopt); 
                break;  
            default:
                break;
        }  
    }

    // optind is for the extra arguments 
    // which are not parsed 
    for (; optind < argc; optind++){      
        printf("extra arguments: %s\n", argv[optind]);  
    } 

    for (int i = 0; i < argc; i++) {
        switch (argv[i]) {
            case 'show':
                show();
                break;

            default:
                break;
        }
    }
      
    return 0; 
}
