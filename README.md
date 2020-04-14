# Getting and Cleaning Data - Course Project

This is the final project for the Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, does the following:

1. Creates a directory for data, if it not exist
2. Downloads the data everytime when you run the R code
3. Unzips the data
4. Loads activity labels and features
5. Extracts only the data for mean and standard deviation
6. Loads and merges train and test datasets
7. Name & converts columns
8. Creates a melted DF with reshape2 functions
9. Creates DF with mean values
10. Create a directory for final dataset
11. Writes final dataset in txt format row.name=FALSE
