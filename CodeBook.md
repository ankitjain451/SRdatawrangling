The script run_analysis.R does the following

Merges the training and the test sets to create one data set.

  
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, 
independent tidy data set with the average of each variable for each activity and each subject.
  
  Here are the descriptions of various variables used in this script
  
  X_test has the feature vectors for the test data set
  y_test has the activity corresponding to each of test data set feature vector
  X_train and y_train are the corresponding varaibles for Training data set
  subject_test and subject_train are the subject identifiers for each of the feature vectors

  features variable and lookup_features lookuptable have the informtion to convert feature variable code into feature description
  
  data_test and data_train are data frames with test and trai data including feature vectors, activity lables and subject identifers
  data_all has the merged training and test data set  
  data_musigma has the measurements only on the mean and standard deviation for each measurement of the data_all data frame
  data_musigma_tidy is the tidy data set created from data_musigma with the average of each variable for each activity and each subject.
  
