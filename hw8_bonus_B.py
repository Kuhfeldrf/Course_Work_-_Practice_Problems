#!/usr/bin/python3

import sys

###birings in sys args and creates file handles
#first argument is descriptor file name
#second argument is data file name
desfilename = sys.argv[1]
datafilename = sys.argv[2]

###creates list for descriptor input based on values high vs low (des_list), also converts values to float
des_list_high = []
des_list_low = []
des_handle = open(desfilename,"r") #(For reading): /home/hub_data_share/data/GeneExprRanges.txt
for des_raw_line in des_handle:
    des_line = des_raw_line.strip().split("\t")
    des_line[0] = float(des_line[0])
    des_line[1] = float(des_line[1])
    if (des_line[0] > des_line[1]):
        des_list_high.append(des_line[0])
        des_list_low.append(des_line[1])
    else:
        des_list_high.append(des_line[1])
        des_list_low.append(des_line[0])
des_handle.close()        
#print(des_list_low,des_list_high,("\n"))

##creates output dictionary and generates key with ranges
output_dic = {}
cur_index = 0
for i in des_list_low:
    #creates keys for nested dictionary
    output_key = f"_{des_list_low[cur_index]}_{des_list_high[cur_index]}_"
    #creates values for nested dictionary
    range_dic_low_val = des_list_low[cur_index]
    range_dic_high_val = des_list_high[cur_index]
    #creasted nessted dictionary
    output_val = {'range_dic': {'low_val': range_dic_low_val,
                                'high_val': range_dic_high_val}}
    output_dic[output_key] = output_val
    cur_index += 1
#print(output_dic,("\n"))

###create df_line var for data input # starting with "df" saves into livavg_list
#removes header from df_handle filre        
#header_line = df_handle.readline().strip()

organ_dic = {'Heart':{'count': 0,
                      'sum': 0},
             'Liver': {'count': 0,
                       'sum': 0},
             'Lung': {'count': 0,
                       'sum': 0},
             'Brain': {'count': 0,
                       'sum': 0}}
#print(organ_dic)                       
expval_dic = {}
df_handle = open(datafilename,"r") #(For reading): /home/hub_data_share/data/GeneExprStudy.txt
for rawline in df_handle:
    line = rawline.strip()
    lineparts_list = line.split("\t")

sumvals = 0
countvals = 0
df_handle = open(datafilename,"r") #(For reading): /home/hub_data_share/data/GeneExprStudy.txt
for rawline in df_handle:
    #print(rawline)
    line = rawline.strip()
    lineparts_list = line.split("\t")
    lineparts_list_s = str(li
    #print(lineparts_list)
    print(lineparts_list_s.find('Heart_1'))
    #if ('Heart_1' in lineparts_list):
        #print(f"{lineparts_list} contains Kidney as a substring")
"""
livavg_dic = {}
#removes NA values
for df_raw_line in df_handle:
    df_line = df_raw_line.strip().split("\t")
    if (df_line[3] != "NA" and df_line[8] != "NA" and df_line[13] != "NA"):
        ###computes averages for liv vars and generates livAvg
        liv1 = float(df_line[3])
        liv2 = float(df_line[8])      
        liv3 = float(df_line[13])     
        livavg = (liv1+liv2+liv3)/3 
        ###ads items to dictionary (livavg_dic)
        gene_livavg_key = df_line[0]
        gene_livavg_val = livavg
        livavg_dic[gene_livavg_key] = gene_livavg_val
df_handle.close() 
"""
'''
###checks range out livavg values and saves to output_dic
for rname in output_dic:
    for gname in livavg_dic:
        if((output_dic[rname]['range_dic']['low_val'] <= livavg_dic[gname]) and (output_dic[rname]['range_dic']['high_val'] >= livavg_dic[gname])):
            livavg_string = f"{gname}\t{livavg_dic[gname]}"
            gname_string = f"{gname}"
            #adds livavg_string to output dictionary
            output_dic[rname].update({gname_string: livavg_string})

###Removes range_dic from output_dic dictionatry and preforms output            
for rname in output_dic:     
    #removes excess from dictiotionary
    del output_dic[rname]['range_dic']
    #saves header and creates files (only once)
    out_handle_filename = f"{outputfilename}{rname}ranges.txt\n"
    out_handle = open(out_handle_filename, "w")
    out_handle.write(f"\tLiver Avg\n")
    out_handle.close()
    ###generates output and removes gene name from inter dictionary
    for gname in output_dic[rname]:
        #creates string for output with liv avg only
        rname_out_string =f"{output_dic[rname][gname]}"
        #appends output files
        out_handle_filename = f"{outputfilename}{rname}ranges.txt\n"
        out_handle = open(out_handle_filename, "a")
        out_handle.write(f"{rname_out_string}\n")
        out_handle.close()
'''