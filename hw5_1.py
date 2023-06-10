#!/usr/bin/python3
import sys

#user input
INPUT_VAR = sys.argv[1]
if INPUT_VAR == "Liver":
    print("Preforming test on ", INPUT_VAR,".",sep="") 
elif INPUT_VAR == "Kidney":
    print("Preforming test on ", INPUT_VAR,".",sep="") 
elif INPUT_VAR == "Heart":
    print("Preforming test on ", INPUT_VAR,".",sep="")    
elif INPUT_VAR == "Brain":
    print("Preforming test on ", INPUT_VAR,".",sep="")
else:
    print("Invalid Tissue. Valid tissues are: Liver, Kidney, Heart, or Brain. Exiting.")