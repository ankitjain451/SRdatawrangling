library(dplyr)

setwd("C:/Users/Karthik/Documents/R/Karthik's projects/datagov/galaxys5data/UCI HAR Dataset/test")
subject_test<-read.table("subject_test.txt")

X_test<-read.table("X_test.txt")
y_test<-read.table("y_test.txt")

setwd("C:/Users/Karthik/Documents/R/Karthik's projects/datagov/galaxys5data/UCI HAR Dataset")
features<-read.table("features.txt")
features<-mutate(features, V1=paste("V",as.character(features$V1),sep=""))

lookup_features <- setNames(as.character(features$V2),as.character(features$V1))
   

X_test<-tbl_df(X_test)
y_test<-tbl_df(y_test)

names(X_test)<-lookup_features[names(X_test)]
names(y_test)[1]="activity"
names(subject_test)[1]="subject"

data_test<-bind_cols(X_test, y_test,subject_test)
data_test$type=1




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

data_all=bind_rows(data_test,data_train)


data_musigma=select(data_all,contains("mean()"),contains("std()"),activity,subject)

activitylabels<-read.table("C:/Users/Karthik/Documents/R/Karthik's projects/datagov/galaxys5data/UCI HAR Dataset/activity_labels.txt")
lookup_activity<-setNames(activitylabels$V2,activitylabels$V1)

data_musigma$activity=lookup_activity[data_musigma$activity]


data_musigma_tidy<-data_musigma%>%
  group_by(activity,subject)%>%
  summarise_each(funs(mean))
n_temp=length(data_musigma_tidy)
names(data_musigma_tidy)[3:n_temp]=as.character(paste("mean_",names(data_musigma_tidy)[3:n_temp]))