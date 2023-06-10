#!/usr/bin/python3

import sys

#firstt argument is index table file name 
#second argument is gene table file name 
#third argument is output file name
index_table_file = sys.argv[1]
gene_table_file = sys.argv[2]
output_file = sys.argv[3]

#saves to output_file, first line + opens
out_handle = open(output_file, "w")
out_handle.write(f"Gene\tHomog\tKidney\n")

###Converts index table into dictionary named ind_dic
ind_dic = {}
gene_list=[]
ind_table_fh = open(index_table_file, "r")
for rawline in ind_table_fh:
    line = rawline.strip()
    line_list = line.split("\t")
    gene_list.append(line_list[0])
    #removes NAs and returns error message if NA present
    if (line_list[1] != "NA"):
        gene_ind_key = line_list[0]
        gene_ind_val = float(line_list[1])
        ind_dic[gene_ind_key] = gene_ind_val
    else:
        print(f"Alert, NA value encountered in homogenate value for {line_list[0]}")


### reads through gene_table 
gene_dic = {}
gene_table_fh = open(gene_table_file, "r")
header_line = gene_table_fh.readline().strip()

for rawline in gene_table_fh:
    line_all = rawline.strip().split("\t")
    #IDK what this does
    if (line_all[0] != ""):
        line = line_all
    #deals with NAs in kidney values and #converts to float, then calculates kid_avg
    if ((line[6] != "NA") and (line[11] != "NA") and (line[16] != "NA")):
        gene_dic_key = line[0]
        kid1 = float(line[6])
        kid2 = float(line[11])
        kid3 = float(line[16])
        kid_avg = (kid1 + kid2 + kid3)/3
        gene_dic[gene_dic_key] = kid_avg
    else: 
        print(f"Alert, NA value encountered in Kidney replicates for {line[0]}")

###compares values in gene_dic to ind_dic  and sends to output if gene(kidney) > ind(homog)
for x in gene_list:
    if ((x in ind_dic) and (x in gene_dic)):
        if (gene_dic[x] > ind_dic[x]):
            #print(x, "send to output", gene_dic[x], ">", ind_dic[x])
            out_handle.write(f"{x}\t{ind_dic[x]}\t{gene_dic[x]}\n")
        #else:
            #print(x, "ignore", gene_dic[x], "<", ind_dic[x])
    elif (x not in ind_dic):
        print(f"Alert, the homogenate value for {x} could not be identified in the file {index_table_file}")
    #elif (x not in gene_dic):
    #    print(f"Alert, NA value encountered in Kidney replicates for {x}")
    