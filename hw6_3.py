#!/usr/bin/python3
import sys

#user input and removes "./hw5_2.py" from 0 location
INPUT_VAR = float(sys.argv[1])

if ((INPUT_VAR >= 1.2 and INPUT_VAR <= 6.7) or (INPUT_VAR >=20.5 and INPUT_VAR <=30.6)):
    print("Argument in valid range, accepted.")
else:
    print("Invalid entry.")