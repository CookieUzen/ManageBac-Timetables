#include <stdio.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
   int c;
   char *cvalue = NULL;

     // put ':' at the starting of the string so compiler can distinguish between '?' and ':'
     while((c = getopt(argc, argv, ":if:lrx")) != -1){ //get option from the getopt() method
      switch(c){
         //For option i, r, l, print that these are options
         case 'i':
         case 'l':
         case 'r':
             cvalue = optarg;
         case '?': //used for some unknown options
            if (optopt == 'c')
              fprintf (stderr, "Option -%c requires an argument.\n", optopt);
            else if (isprint (optopt))
              fprintf (stderr, "Unknown option `-%c'.\n", optopt);
            else
              fprintf (stderr,
                       "Unknown option character `\\x%x'.\n",
                       optopt);
                return 1;
          default:
            abort ();
    }

    for (index = optind; index < argc; index++) {
        printf ("Non-option argument %s\n", argv[index]);
    }
      return 0;
   }
}
