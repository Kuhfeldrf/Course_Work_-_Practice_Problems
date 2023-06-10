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
# Applied Machine Learning
This repository features several pythons scripts written for the Computer Science Applied Machine Learning course at Orgon State

Descriptions of different assigments:
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
**Notebook 2: Data Exploration, Preprocessing & Similarity Metrics**   
      Define pandas, DataFrame and Series. (MLO 5)
      Demonstrate the ability to find and add a dataset to a Notebook, and load the data into a pandas DataFrame. (MLO 5)
      Characterize a data set using the pandas API. (MLO 5)
      Visualize data using pandas and MatPlotLib. (MLO 5)
      Demonstrate handling missing data within a data set using the pandas API. (MLO 5)
      Synthesize new features from a data set with the pandas API. (MLO 5)
 
 **Notebook 3: Classification with k-Nearest Neighbors**
      Iteratively experiment and test a classifier with different values of k. (MLOs 2, 3, & 5)
      Select an appropriate value for k after analyzing classification errors. (MLOs 3 & 5)
      Engage in an ML classification process to solve a classification problem. (MLOs 2 & 5)
      Apply the scikit-learn KNeighborsClassifier to predict class labels from a real data set. (MLOs 2 & 5)
      
**Week 4: Classification with Perceptrons**      
      Implement a test procedure for a perceptron classifier. (MLOs 1 - 4)
      Analyze the accuracy of a perceptron classifier. (MLOs 3 & 4)
      Engage in an ML classification process to solve a classification problem. (MLOs 2 & 4)
      Apply the scikit-learn Perceptron to predict class labels from a real data set. (MLOs 2 & 4)

**Notebook 6: Predicting Housing Prices with Linear Regression**
      Implement a training procedure for a multiple linear regression model. (MLOs 2 - 4)
      Engage in an ML supervised learning process to solve a regression problem. (MLOs 3 - 5)
      Analyze the accuracy of a linear regression model. (MLOs 4 & 5)
      Apply the scikit-learn SGDRegressor to predict values based on training examples in a real data set. (MLOs 1 & 5)

**Notebook 7: Classification with Logistic Regression**
      Implement a training procedure for a logistic regression classifier. (MLOs 2 - 4)
      Narrate an ML supervised learning process to solve a classification problem. (MLOs 3 & 4)
      Analyze the accuracy of a logistic regression model. (MLOs 3 & 4)
      Apply the scikit-learn LogisticRegression model to predict class labels based on training examples in a real data set. (MLO 4)

**Notebook 8: Classification with Support Vector Machines**
      Engage in an ML classification process to solve a classification problem. (MLOs 2 - 4)
      Apply the scikit-learn SVC to predict class labels from a real data set. (MLOs 2 - 4)
      Analyze the accuracy of an SVM classifier. (MLOs 3 & 4)

**Notebook 9: Text Classification & Sentiment Analysis**
      Demonstrate a machine learning process and workflow in a Jupyter Notebook. (MLOs 2 - 4)
      Apply a classification model to perform sentiment analysis with a real data set. (MLOs 2 - 4)
      
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------      
# Stats Quest YouTube Tutorial
This repository features several R and Python scripts following YouTube tutorials

Different tutorials:
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
StatQuest Logistic Regression in R

StatQuest Classification Trees in Python from Start to Finish

StatQuest ROC and AUC in R

StatQuest Ridge, Lasso and Elastic-Net Regression in R

StatQuest MDS and PCoA in R

StatQuest PCA in Python

StatQuest PCA in R

heart_disease_probabilities

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------      
# CS 546 Networks in Computational Biology
This repository features and Python scripts for the Networks in Computational Biology Course

**Descriptions of different assigments:**
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------      
**Homework Assignment 1 - metabolic network analysis**

Overview: 
In this homework assignment you will write a notebook (Google Colab or Jupyter) to analyze a large human metabolic reaction network derived from the HumanCyc (humancyc.orgLinks to an external site.) database. You will get this network from a data file in edge-list format. You can use any programming language and any network analysis toolbox that you like (or no network analysis toolbox, if you prefer). I recommend using python and igraph, and there is a template notebookLinks to an external site. [Google Colab] available that provides hints that are tailored to a python-igraph implementation.

You have four problems to solve, each involving some analysis of the graph described by the edge-list file hsmetnet.txt.

1. In this graph, each vertex is either a metabolite or a reaction. Each edge is an association of a metabolite with a reaction. How many distinct metabolites are there in the graph? How many reactions? How many edges are there? Calculate the degree 
 of each of the metabolite vertices (you don’t need to calculate the degree for the vertices that correspond to reactions). What are the top six metabolites in terms of vertex degree in the graph?  (You can assume that no metabolite name has "REACTION" as a substring).

2. Plot the distribution of the degrees of all the metabolite vertices, on log-log scale. Is the degree distribution well-described by a power law? Calculate the exponent 
of the best-fit power-law.  How does the  that you get compare to the estimate of the power-law exponent reported by Jeong et al. in their 2000 article in Nature, “The large-scale organization of metabolic networks” (vol. 407, pp. 651–654) (see page 14 of reading-for-class-06.pdf)? (Note: there are two exponents referred to in the caption for Figure 2 and in the accompanying article text;  and They have the same value in the metabolic network, and thus, you can compare your value to either of them.) Based on structure of the network that you analyzed (bipartite, containing reactions) vs. the structure of the network that they analyzed (network projected to a network containing only metabolites), is it appropriate to compare the exponents? Why or why not?

3. Calculate the shortest-path-length between all pairs of metabolites (vertices) in the graph, treating the graph as if it were undirected. Using the all-pairs distances that you just obtained, calculate the average for all pairs of metabolites in the giant (weakly connected) component of the network, by throwing away any distance value if it is infinite or zero. (Note: in calculating your average, do not include pairs of vertices that are the same vertex as both source and destination, which would have a distance of zero). Also using the all-pairs distances that you previously obtained, calculate the maximum  (throwing away infinite values, as before) in the giant (weakly connected) component of the network (i.e., you are calculating the diameter of the giant component, according to Newman's definition of diameter). Why are the average geodesic distances that we get, roughly twice those reported in Fig. 3b of Jeong et al., 2000?

4. Calculate the shortest-paths betweenness centrality for all metabolites in the directed network. Plot the scatter plot of betweenness centrality (normalized to, i.e., divided by, M2, where M is the total number of metabolites) vs. vertex degree (here, "degree" means in-degree plus out-degree) for all metabolites, on log-log scale. Among metabolites with degree what metabolite has highest betweenness centrality in the network? Search on this metabolite in the HumanCyc database at humancyc.orgLinks to an external site., using the "Quick Search" box. Click on the hyperlinked metabolite that is displayed on the search results page. Click on the "reactions" tab, in the tabbed window in the lower part of the page. What important metabolic cycles is this metabolite involved in? Click on the "urea cycle". What is the known consequence of absence of an enzyme in this pathway?

**Homework Assignment 2 - network motif analysis**

Overview: 
In this homework assignment you will analyze a bacterial gene regulatory network to from the standpoint of network motifs.  The network (which is a tab-delimited text file in edge-list format that is available in the class S3 bucket via HTTPSLinks to an external site. ) that you will analyze is a literature-curated list of transcription-factor–to–target-gene interactions in the model bacterial species, E. coli. I recommend using python and igraph, and there is a template notebookLinks to an external site. [Google Colab] available that provides hints that are tailored to a python-igraph implementation.

1. There are 13 different types of connected 3-vertex motifs (“isomorphism classes”) for a digraph. Which one of these motifs is most frequent in the E. coli regulatory network?

2. Which one of these motifs has a count of 47 in the regulatory network? I’ll refer to this specific motif as the “mystery motif”, or MM.  This is the motif that Shen-Orr et al. are claiming is enriched in the metabolic network. Let's assess the enrichment significance ourselves. To do so,  the counts of the MM needs to be computed for each network within an ensemble of random networks. Follow the approach used in Shen-Orr et al., which is to take the network and to shuffle the associations between source and target vertices while preserving the in- and out- degree of each vertex (and while avoiding creating self-loops in the shuffling; igraph users, see the rewire method). For each rewired graph, calculate the count of the MM in the corresponding digraph, and save it. Do this 1,000 times, and you will now have a vector of 1,000 MM count values from shuffled networks, and a single MM count value from the real network. What are the mean and standard deviation of the MM counts for the 1,000 random networks?

3. What is the Z-score for enrichment of the MM count for the real network vs. the ensemble of random networks?  Does this Z-score correspond to a statistically significant positive enrichment?

4. What is the ratio of the MM count for the real network to the average MM count for the random networks?

5. How does ratio compare to the same ratio for the data in Table 1 in Shen-Orr et al., Nature Genetics, 2002?

6. Given the modest ratio of the MM frequency in the real network vs. randomly shuffled network, should we entertain the possibility that the high frequency of MMs in the real network could be a consequence of the degree distribution rather than evolution specifically “favoring” FFLs as a building block for gene regulatory networks?

**Homework Assignment 3 - max flow / min cuts**

Overview: 
For this homework, you will be asked to analyze a couple of networks from the standpoint of maximum flow / minimum cuts. I recommend using python and igraph, and there is a template notebookLinks to an external site. [Google Colab] available that provides hints that are tailored to a python-igraph implementation.

Part 1:
In the following digraph, what edge has maximum flow value as defined in Newman Section 6.12?  What is the value of the maximum flow for that edge? (Yes, I know that one can solve this by inspection; but here you are being asked to write code to solve it).

A directed graph with six vertices: D->E, E->X, A->X, A->E, C->X, A->C, A->B

CS546 students: How one would do it using a functional programming style, without a "for loop"?  (Hint, list comprehension is not considered a "for loop" here, even though it uses the keyword "for"). You can show code or if you have an idea but are not quite sure of the correct syntax, you can describe your idea in words.

Part 2:
In the human metabolic network, what is the maximum flow between "alpha-D-glucose" and "pyruvate"? Why do you think that this pair of vertices has such a high maximum flow?

**Final Project Notebook**

Overview: 
For your CS446/546 final project, your team will prepare and submit a Google Colab notebook or Jupyter notebook (as an ".ipynb" file) documenting a computational biology project that you carry out. Your final project should involve analyzing some kind of biological network or a biological data-set from a network standpoint; but within that overall requirement, there is a broad range of possibilities. Your project could be to learn a network structure from measurement data; cluster an existing biological network to identify functional modules; analyze one or more centralities vs. vertex degree for a given biological network; etc. Your project should have a specific question that you pose, that you answer by carrying out a computational analysis. 

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------      
