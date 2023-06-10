# Python_Computing-in-the-Life-Science
This repository features several pythons scripts written for the Biological Data Science Computing in the Life Science course at Orgon State

Descriptions of different assigments:
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
**8_1**     
      hw8.sh will call hw8.py with three arguments: the first argument will be an ‘index table’ file for reading, the second argument will be a file of data for reading, the third argument will be a string representing an output file name. 
      Files/names:      
          1.	(For reading): /home/hub_data_share/data/GeneTable.txt      
          This is a tab-delimited file of gene names and their associated average expression levels in a whole-organism homogenate. 
          2.	(For reading):    
          /home/hub_data_share/data/GeneExprStudy.txt 
          3.	(For writing):    
      An output file name:    
      Kidney_Avg_Greater.txt  
      hw8.py will first read the index table into a dictionary, with gene names as keys and the whole-organism homogenate expression levels as values. If an NA is encountered in GeneTable.txt, then don't add its key-value pair into your dictionary but instead print to the screen a user-alert message:     
      Alert, NA value encountered in homogenate value for Gene_N  
      (where Gene_N is replaced by the actual gene label associated with the NA value).   
      The program will then read through each line of the data file GeneExprStudy.txt, testing whether the average of the Kidney samples associated with each gene (i.e.  the average of the three Kidney values in the same line as the gene) exceeds the whole-organism homogenate expression level associated with the gene.  For each line, in order to find the whole-organism homogenate value, perform a "lookup" on the gene's name in the dictionary that you have already stored as described above.   
      If the Kidney average expression level for a gene is greater than the gene's homogenate expression level, write to the output file the gene’s name, the expression level in homogenate, and Kidney average expression level.  Separate these three values with a tab. Label the columns in the output file header as “Gene”, “Homog”, and “Kidney”.   
      If an ‘NA’ value is encountered in computing the gene expression average, ignore this gene for comparison purposes but print to the screen a user-alert message: 
      Alert, NA value encountered in Kidney replicates for Gene_N 
      (where N is replaced by the actual number in the gene label associated with the NA value).      
      If the whole-organism homogenate dictionary "lookup" fails (this can happen if there is a gene whose homogenate key-value pair isn't in the dictionary as it was an NA value), also ignore this gene for comparison purposes but print to the screen a user-alert message:    
      Alert, the homogenate value for Gene_N could not be identified in the file Homogenate_Table_Filename  
      (where N is replaced by the actual number in the associated gene label and Homogenate_Table_Filename is replaced by the actual name of the whole-organism homogenate file as input by the user which can include its path).   
**8_Bonus_A**     
      Bonus problem version A:      
      In a directory named hw8_bonus_A, create the following Python and shell scripts (use names hw8_bonus_A.sh and hw8_bonus_B.py).      
      Perform the same function as HW #7 Bonus, but rather than printing out entire lines in the output files, just print out two tab-delimited columns: the gene name, and the average of the liver expression values.  Give the average column a header label “Liver Avg”.    Don’t loop over the lines in the data file more than once—use a dictionary to store the appropriate values as you read in the data file.  (Don’t store any values that involve ‘NA’.)  Then, after you’ve closed the data file, use the dictionary to print the appropriate values to each output file.   
      Hint: Consider using a dictionary of dictionaries, where the ‘outer’ dictionary keys are strings representing your ranges. Each range dictionary element would be a dictionary with gene names as the keys and liver averages as the values.    
**8_Bonus_B**     
      (Naming: hw8_bonus_B directory, hw8_bonus_B.sh, hw8_bonus_B.py)   
      Here is a code-snippet recipe for testing whether a string such as “Kidney” is contained at least once somewhere inside another string, let’s imagine that other string is in a variable named header_part: 
      if ("Kidney" in header_part): 
          print(f"{header_part} contains Kidney as a substring")  
      Use this concept to perform the homework in version A above for *all tissues* in the data file, without much extra code, by:
          1.	Defining a data structure (dictionary convenient but lists will work) to hold each of the desired tissue labels (Kidney, Lung, Heart, etc) and the current sum and count for each type of expression value during each line’s computation of the average. (Instead of computing the average ‘by hand’ explicitly in the code for each line, you can compute an average by keeping track of the sum of the values and the number of values used to create that sum, and then when all items are considered simply divide the sum by the value count).  
          2.	From the header line, creating a data structure which associates each line part index (column index) to the appropriate tissue using the match operator idea described above. 
          3.	Looping over each line, (testing for NA then) updating the sum and count appropriately for that column index; after each line is read, compute and store the averages in the dictionary of dictionaries.    
          4.	When you go to print out the files, print an appropriately labeled file according to each tissue and range like this:   
      Lung_-10.0_-5.2_range.txt     

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
**7_1**     
      hw7.sh will call hw7.py with two arguments: the first argument will be a file of data for reading, the second argument will be the name of an output file.  The file for reading should be GeneExprStudy.txt. Instead of copying this file to your hw7 directory, just refer to it in the /home/hub_data_share/data directory (i.e. provide the full path to the file when referring to it).  The output file should be named Gene_Expr_Study_Filtered.txt. 
      hw7.py will create a ‘data filter’:  it will read the file whose name is passed in as the first argument line by line, and write out a version of that file containing the same header but only those data lines representing genes having ALL of the following properties:   
            1.	Expressed in blood and not containing NA in any data value. 
            2.	All Kidney expression values are at or below -1.5.    
            3.	At least one Liver expression value above 2.0, with all Liver values above 1.5.     
      In this scenario, you can assume that the input file will be formatted exactly as GeneExprStudy.txt is formatted, with all columns in the same order (you need not find the correct columns by their header labels).    
**7_Bonus** 
      hw7_bonus.sh will call hw7_bonus.py with three arguments: the first argument will be a ‘descriptor’ file for reading, the second argument will be a file of data for reading, the third argument will be a string representing the first portion of an output file name for a series of output files. 
      Files/names:      
          1.	(For reading): /home/hub_data_share/data/GeneExprRanges.txt 
          This is a tab-delimited file of gene expression ranges of interest.  It may contain any number of gene expression ranges (however the example has only a few            ranges).      
          2.	(For reading):    
          /home/hub_data_share/data/GeneExprStudy.txt 
          3.	(For writing):    
      A string that produces a base file name—in our case let the base file name be: GenesSelectedByLiverExpr     
      hw7_bonus.py will create a series of output files, one for each range provided in the range descriptor file (GeneExprRanges.txt).  It will read in the gene expression ranges, then filter the data in the data file by selecting only genes within each range of expression values for Liver.  By this we mean explicitly:   
      Only data lines associated with genes such that all Liver expression values are numerical quantities (not “NA”), and the average of these Liver expression values falls within the range (inclusive of range endpoints), will be printed to the respective output file.  For these lines, the entire original data line will be printed to the output file. (These are the only filter conditions-- the filter conditions of hw7 do not apply, that is a different set of filter conditions).   
      Output files will be named according to their ranges as in the following example:   
      If the range is -10.0 to -5.2, then the output file name will be  
      GenesSelectedByLiverExpr_-10.0_-5.2_range.txt   

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
**6_1, 6_2, 6_3:**      
      Create identical scripts to those in your hw5 (but with the hw6 label on your programs/scripts), however for this homework, use logical operators ‘AND’ (and) or ‘OR’ (or) or 'NOT' (not) to simplify your code.  
      
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
**5_1:**    
      hw5_1.py and hw5_1.sh   
      The user will enter a string as the first argument on the command line.  If the string is “Liver”, “Kidney”, “Heart”, or “Brain”, then, assuming the input is stored in the variable INPUT_VAR, print out (with INPUT_VAR below replaced by the value stored in this variable):     
      Performing test on INPUT_VAR. 
      Otherwise, print: 
      Invalid Tissue. Valid tissues are: Liver, Kidney, Heart, or Brain. Exiting.   
      and then exit the program.  To exit, you can use the exit command without arguments as in the videos, i.e. exit().  Of course using the exit() command is only necessary if you want to issue this command before the last line of your program.      
**5_2:**    
      hw5_2.py and hw5_2.sh   
      The user will enter three numbers (integers) as the first three arguments on the command line.  If the user fails to enter exactly three arguments, print:  
      Three arguments required. Exiting.  
      then exit the program.  For each of the three arguments entered, if the argument is equal to any of these valid choices: 5, 6, or 7, then, assuming the input is stored in the variable INPUT_VAR, print out (with INPUT_VAR below replaced by the value stored in this variable):  
      INPUT_VAR accepted.     
      If the argument is not equal to a valid choice, print out (with INPUT_VAR below replaced by the value stored in this variable):     
      INPUT_VAR is an invalid argument, not accepted. 
      For example, suppose the user enters the set of arguments 2, 6, and 8.  The program will print: 
      2 is an invalid argument, not accepted.   
      6 accepted. 
      8 is an invalid argument, not accepted.   

**5-3:**    
      hw5_3.py and hw5_3.sh   
      The user will enter a number as the first argument-- this could be any number, including a floating point number.  If the number is in the range 1.2 to 6.7, inclusive of endpoints, or if the number is in the range 20.5 to 30.6 (inclusive of endpoints), print:     
      Argument in valid range, accepted.  
      Otherwise, print: 
      Invalid entry.    
      
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------      
