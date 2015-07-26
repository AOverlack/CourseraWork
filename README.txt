---
title: "README"
author: "AOverlack"
date: "Saturday, July 25, 2015"
output: html_document

#Approach to create a tidy data set
This markdown file describes the process to produc a tidy data set containing the Average of the values of the "mean"" and "std" measurements in the data files *X-train* and *X-test*, which have been concatenated to one data frame. It is assumed that the manual steps indicated below will be performed prior to running the R code "run_analysis.R".

The process consists of the following, manual and programatic steps:
A. Manual download and unzipping of the files from the site and storing in a "data"folder in the working directory:
        https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

B. Running the "run_analysis.R" scrip that performs the following steps:

1. Reading the files X-train.txt and X-test.txt into a dataframe each ("DFTrain"" and "DFTest") using the *read.table* function.
2. Reading the files subject-train.txt and subject-test.txt into  a data frame each using the *read.table* function., to create a vector with the subject code per observation (7352 and 2947 respectively for train- and test data)
3. Reading the files y-train.txt and y-test.txt into a dataframe each using the *read.table* function, to create a vector with the activity codes per observation (7352, and 2947 respectively for train- and test data)
4. Reading the "features.txt" file into a data frame to add the column headers to the data frame.
5. Removing duplicate columns from the data frame
6. Selecting only the columns with "mean" and "std" values (mean and standar deviation)
7. Sorting the table by Activity (descending) and subject (ascending) respectively
8. Aggregation of the values in the columns to averages per activity and subject respectively.
9 Creating output to a text file with the name "TidyData-Means.txt"


