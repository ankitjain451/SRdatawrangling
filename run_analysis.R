library(dplyr)

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Read the test data set
setwd("C:/Users/Karthik/Documents/R/Karthik's projects/datagov/galaxys5data/UCI HAR Dataset/test")
subject_test<-read.table("subject_test.txt")

X_test<-read.table("X_test.txt")
y_test<-read.table("y_test.txt")


## Read the feature names
setwd("C:/Users/Karthik/Documents/R/Karthik's projects/datagov/galaxys5data/UCI HAR Dataset")
features<-read.table("features.txt")
features<-mutate(features, V1=paste("V",as.character(features$V1),sep=""))

## Make a look up table to convert column names into feature name
lookup_features <- setNames(as.character(features$V2),as.character(features$V1))
   

X_test<-tbl_df(X_test)
y_test<-tbl_df(y_test)

names(X_test)<-lookup_features[names(X_test)]

## Name columns of y-test and subject
names(y_test)[1]="activity"
names(subject_test)[1]="subject"

## Bind columns together to include all test data columns
## Use a column named type to differentiate between test and training data
## type=1 for test and =2 for training data
data_test<-bind_cols(X_test, y_test,subject_test)
data_test$type=1


## Repeat the above process for training data set

subject_train<-read.table("C:/Users/Karthik/Documents/R/Karthik's projects/datagov/galaxys5data/UCI HAR Dataset/train/subject_train.txt")

X_train<-read.table("C:/Users/Karthik/Documents/R/Karthik's projects/datagov/galaxys5data/UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("C:/Users/Karthik/Documents/R/Karthik's projects/datagov/galaxys5data/UCI HAR Dataset/train/y_train.txt")

X_train<-tbl_df(X_train)
y_train<-tbl_df(y_train)

names(X_train)<-lookup_features[names(X_train)]
names(y_train)[1]="activity"
names(subject_train)[1]="subject"

data_train<-bind_cols(X_train, y_train,subject_train)
data_train$type=2



## Merge the training and test data sets together
data_all=bind_rows(data_test,data_train)

##Extract only the measurements on the mean and standard deviation for each measurement.
data_musigma=select(data_all,contains("mean()"),contains("std()"),activity,subject)

##Use descriptive activity names to name the activities in the data set
activitylabels<-read.table("C:/Users/Karthik/Documents/R/Karthik's projects/datagov/galaxys5data/UCI HAR Dataset/activity_labels.txt")
lookup_activity<-setNames(activitylabels$V2,activitylabels$V1)

## Note: mutate did not work for the command below as there were repetitive column names
data_musigma$activity=lookup_activity[data_musigma$activity]

##From the data set data_musigma above, create a second, independent tidy data set with 
##the average of each variable for each activity and each subject.
data_musigma_tidy<-data_musigma%>%
  group_by(activity,subject)%>%
  summarise_each(funs(mean))
n_temp=length(data_musigma_tidy)
names(data_musigma_tidy)[3:n_temp]=as.character(paste("mean_",names(data_musigma_tidy)[3:n_temp]))