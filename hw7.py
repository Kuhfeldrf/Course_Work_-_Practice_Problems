#!/usr/bin/python3

import sys

#first argument is input file name
#second argument is output file name
datafilename = sys.argv[1]
outputfilename = sys.argv[2]

#tracking the file handle 
df_handle = open(datafilename,"r")
out_handle = open(outputfilename, "w")


#To read the header line of file
header_line = df_handle.readline().strip()
out_handle.write("\t")
out_handle.write(header_line)
out_handle.write("\n")   

#line_num = 0
for raw_lines in df_handle:
    lines = raw_lines.strip().split("\t")

    
    if lines[1] == "Y": 
        if lines[2:] != "NA":
            filtered_lines = ' '.join(map(str,lines)) #converts list -> string
            #print(filtered_line)
            #out_handle.write(filtered_lines)


    #line_num = line_num + 1
    line_list = raw_lines.rstrip().split("\t")
    #print (f"line {line_num}:", line_list) # lines are list now having 17 items
    
###Part 1) determines if gene is expressed in blood and saves as 1 or 0  ( Expressed in blood and not containing NA in any data value. )
    expr_in_blood = line_list[1]
    if (expr_in_blood == "Y"):
        is_expr_in_blood = 1
    else:
        is_expr_in_blood = 0
    #print (f"Expressed in blood: {expr_in_blood} the value will be: {is_expr_in_blood}")
    gene_expr_values = line_list[2:]
    no_NAs = 1

#identiys any NA present and converst to 0 or 1    
    for values in gene_expr_values:
        if values == "NA":
            no_NAs = 0
        
    #print (f"{no_NAs} {raw_lines}")

#converts non NAs to float    
    if (no_NAs == 1):
       for cur_index in range(0, len(gene_expr_values)):
        cur_value =  gene_expr_values[cur_index]
        cur_value_float = float(cur_value)
        gene_expr_values[cur_index] = cur_value_float

###Part 2) returns output of gene line if all kidney values are < -1.5 (All Kidney expression values are at or below -1.5.)
        
        kid1 = float(line_list[6])
        kid2 = float(line_list[11])
        kid3 = float(line_list[16])
        kid = 0 
        for values in gene_expr_values:
            if (kid1 <= -1.5 and kid2 <= -1.5 and kid3 <= -1.5):
                kid = 1
            else:
                kid = 0

###Part 3) returns output of gene line if At least one Liver expression value above 2.0, with all Liver values above 1.5.

        
        liv1 = float(line_list[3])
        liv2 = float(line_list[8])
        liv3 = float(line_list[13])
        liv = 0
        for values in gene_expr_values:
            if ((liv1 >= 1.5 and liv2 >= 1.5 and liv3 >= 1.5) and (liv1 >= 2 or liv2 >= 2 or liv3 >=2)):
                liv = 1
            else:
                liv = 0
                    
#writes to outpute file if three conditions are meet        
    #for values in gene_expr_values:
    if (is_expr_in_blood == 1 and no_NAs == 1 and kid == 1 and liv == 1):
        out_handle.write(raw_lines)
     
        #print (f"{raw_lines}")
        #print (f"Expressed in blood: {expr_in_blood} the value will be: {is_expr_in_blood}")
