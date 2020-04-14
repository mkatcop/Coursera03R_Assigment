library(reshape2)

# create a directory for data
if(!file.exists("data")){dir.create("data")}

## download the data everytime when you run the R code
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="data/dataFiles.zip")

## unzip the data
unzip(zipfile = "data/dataFiles.zip", exdir = "data")

# Load activity labels and features
activityLabels <- read.table("data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
features <- read.table("data/UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)


# Extract only the data on mean and standard deviation
features_for_finalDF <- grep(".*mean.*|.*std.*", features[,2])
features_for_finalDF.names <- features[features_for_finalDF,2]
features_for_finalDF.names = gsub('-mean', 'Mean', features_for_finalDF.names)
features_for_finalDF.names = gsub('-std', 'Std', features_for_finalDF.names)
features_for_finalDF.names <- gsub('[-()]', '', features_for_finalDF.names)

# Load train datasets
trainDF <- read.table("data/UCI HAR Dataset/train/X_train.txt")[features_for_finalDF]
trainActivity <- read.table("data/UCI HAR Dataset/train/Y_train.txt")
trainSubject <- read.table("data/UCI HAR Dataset/train/subject_train.txt")

# Merge train datasets
trainDF <- cbind(trainSubject,trainActivity,trainDF)

# Load test datasets
testDF <- read.table("data/UCI HAR Dataset/test/X_test.txt")[features_for_finalDF]
testActivity <- read.table("data/UCI HAR Dataset/test/y_test.txt")
testSubject <- read.table("data/UCI HAR Dataset/test/subject_test.txt")

# Merge test datasets
testDF <- cbind(testSubject, testActivity, testDF)

# merge train and test data
allDF <- rbind(trainDF,testDF)

# Name columns
colnames(allDF) <- c("subject", "activity", features_for_finalDF.names)

# convert activity & subject into factors
allDF$activity <- factor(allDF$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allDF$subject <- as.factor(allDF$subject)

# create a melted DF with reshape2 functions
allDF.melted <- melt(allDF, id = c("subject", "activity"))

# create DF with mean values
allDF.mean <- dcast(allDF.melted, subject + activity ~ variable, mean)

# create a directory for final dataset
if(!file.exists("data/finalData")){dir.create("data/finalData")}

# write final dataset in txt format row.name=FALSE
write.table(allDF.mean, "data/finalData/tidy.txt", row.name=FALSE)
