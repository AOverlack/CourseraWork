## PREPRATORY MAUNAL ACTIVITY
## Download the fileS from the file address: 
## Unzip the files mually in windows 
## Create folder in working directory, named "data".
## Store the unzipped files "X_train.txt" and "X_test.txt","subject_train.txt",
## "subject_test.txt" "features.txt","y_test.txt", "y_train.txt" and "activity_labels.txt"
## in the folder "data"


## Read fixed-width text file into dataframes, using read.table

DFTest <- read.table("./data/X_test.txt")
DFTrain <- read.table("./data/X_train.txt")

## Create "Subject" identifier data frame for both test and training set (Length!)
Subjecttest <- read.table("./data/subject_test.txt")
Subjecttrain <- read.table("./data/subject_train.txt")

##Add column name to both "subject" data frames using "dplyr" package

library(dplyr)
Subjecttest <- rename(Subjecttest,Subject=V1)
Subjecttrain <- rename(Subjecttrain,Subject=V1)

## Create "Activity" identifier data frame for test and training (Different Lengths !)
Activitytest <- read.table("./data/y_test.txt")
Activitytrain <- read.table("./data/y_train.txt")

Add column name to both "Activity" data frames using "dplyr"package

Activitytest <- rename(Activitytest,Activity=V1)
Activitytrain <- rename(Activitytrain,Activity=V1)

## Create Headers data frame from "features.txt" dataset
Headers <- read.table("./data/features.txt")

## NB Headers prove to contain double entries so these and the corresponding 
## columns in the DFTest and DFtrain sets must be removed. So first we need to add the Column
## names to the data frames DFTest and DFTrain

names(DFTest) <- Headers$V2
names(DFTrain) <- Headers$V2

## Add the columns for Activity and Subject to DFTest and DFTrain and bind both dataframes

DFTestWide <- cbind(Activitytest,Subjecttest,DFTest)
DFTrainWide <- cbind(Activitytrain,Subjecttrain,DFTrain)
DFTotal <- rbind(DFTestWide,DFTrainWide)

## Remove duplicate column entries

DFTotalClean <- DFTotal[,unique(colnames(DFTotal))]

## Replace the numerical values in "Activity" column by names of activity from "activity_labels.txt"

Activity <- read.table("./data/activity_labels.txt")

DFTotalClean$Activity <- Activity$V2[match(DFTotalClean$Activity,Activity$V1)]

## Select only relevant (mean and std) variables from DFTotal, using "dplyr"package
## and sort by Activity and Subject

DFinal <- select(DFTotalClean,contains("Activity"),contains("Subject"),contains("-mean()-"),contains("-std()-"))
DFinalSort <- DFinal [with(DFinal,order(Activity,Subject)),]

## Export to a text file called "TidyData-1.txt".

write.table(DFinalSort,file="TidyData-1",row.names=FALSE)

## Create tidy dataset containing only averages of variables for each Activity and each Subject.
## Transform DFinalSort into a table

library(data.table)

DT <- data.table(DFinalSort)

## Assign variable names for which the mean must be calculated
## Excluding the first 2 (Activity and Subject))

variables <- tail(names(DT),-2)

## Create table with Mean values per variable, by Activity and by Subject

DTMean <- DT[,lapply(.SD,mean),.SDcols=variables, by=list(Activity,Subject)]

## Create tidy dataset with mean values

write.table(DTMean,file="TidyData-Means.txt",row.names=FALSE)






