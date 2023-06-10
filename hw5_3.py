#!/usr/bin/python3
import sys
#defines variables
num_small = 0
num_big = 0

#imports from user
num = float(sys.argv[1])

#creates var for lower range
if num >= 1.2:
    if num <=6.7:
        num_small += num
        
#creates var for higher range
if num >= 20.5:
    if num <=30.6:
        num_big= num
        
#logic statement to test is var in either ranger and returns string output        
if num_big >= 1:
    print("Argument in valid range, accepted.")
elif num_small >= 1:
        print("Argument in valid range, accepted.")
else:
   print("Invalid entry.")    