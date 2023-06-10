#!/usr/bin/python3

import sys

###first argument is descriptor file name
###second argument is data file name
###third argument is output file name
desfilename = sys.argv[1]
datafilename = sys.argv[2]
outputfilename = sys.argv[3]

###tracking the inputfile handle 
des_handle = open(desfilename,"r") #(For reading): /home/hub_data_share/data/GeneExprRanges.txt
df_handle = open(datafilename,"r") #(For reading): /home/hub_data_share/data/GeneExprStudy.txt

###creates list for descriptor input based on values high vs low (des_list), also converts values to float
des_list_high = []
des_list_low = []
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

###removes header from df_handle filre        
header_line = df_handle.readline().strip()

###crease a list to deal with multiple file names
n_range = (len(des_list_low)-1)
out_handle_list=[]
i = 0
while i <= n_range:
    out_handle_list.append(f"{outputfilename}")
    i += 1
counter = 0    

###create df_line var for data input # starting with "df" saves into livavg_list
for df_raw_line in df_handle:
    df_line = df_raw_line.strip().split("\t")
    if (df_line[3] != "NA" and df_line[8] != "NA" and df_line[13] != "NA"):
        ###computes averages for liv vars and generates livAvg
        liv1 = float(df_line[3])
        liv2 = float(df_line[8])      
        liv3 = float(df_line[13])     
        livavg = (liv1+liv2+liv3)/3 
        
###loop to sort values 
        cur_index = 0
        stop_index = len(des_list_high) - 1
        while cur_index <= stop_index:
            ###saves head_line to all file names
            if counter == 0:
                out_handle_filename = f"{out_handle_list[cur_index]}_{des_list_high[cur_index]}_{des_list_low[cur_index]}_ranges.txt"
                out_handle = open(out_handle_filename, "w")
                out_handle.write(f"\t{header_line}\n")
                out_handle.close()
            ###Saves genetic lines to file that are within ranges
            if ((livavg <= des_list_high[cur_index]) and (livavg >= des_list_low[cur_index])):
                out_handle_filename = f"{out_handle_list[cur_index]}_{des_list_high[cur_index]}_{des_list_low[cur_index]}_ranges.txt"
                out_handle = open(out_handle_filename, "a")
                out_handle.write(df_raw_line)
                out_handle.close()
                cur_index += 1
            else:
                cur_index += 1
        #resets tickers to continue loop
        cur_index = 0
        counter = 1