#!/usr/bin/python3
import sys

#user input and removes "./hw5_2.py" from 0 location
INPUT_VAR = list(sys.argv)
INPUT_VAR.pop(0)

      
#determins input legneths and prints message
if (len(INPUT_VAR) != 3):
   print("Three arguments required. Exiting.")
   exit()
#returnacepted if 5,6,or7 is entered by user otherwise returens invaled agrument notification

for num in INPUT_VAR:
    if (num == "5" or num == "6" or num == "7"):
        print(num,"accepted.")
    else:
        print(num, "is an invalid argument, not accepted.")