# GettingAndCleaningDataCourseProject
The run_analisys script excecute the following actions:
1) get the complete list of flles in "UCI HAR Dataset" folder tree
2) create a vector of the file names that contain the data required for the elaboration. The files are: "activity_labels","subject_test","X_test","y_test","subject_train","X_train","y_train", "features.txt"
3) on the basis of the names in the vector at list item 2,the script creates a list that contains the dataframes required for the elaboration. this list of data frame contains jet both the train and the test data set
4) creates a list of dataframes. Each dataframe in obtained by binding the related _test and the _train dataframes. Eg. data frame labeled as X is created by rbind(X_test, X_train)
5) rename V1 column of subject dataframe in "subject"
6) rename V1 column of y dataframe in "activity"
7) rename all data frame "X" columns with the values of "features" data frame. in the way the measurements columns of "X" data frame has dexcriptive names
8) by cbind, add column "subject" of data frame "subject" to data frame "X"
9) by cbind, add column "activity" of data frame "y" to data frame "x". The resulting dataframe is named single_df and it merges the training and the test sets in one data set.  In particolar it icludes subject data, activity data and measurements data labeled with descriptive names
10) create a vector that contains columns position related to subject, activity, mean and standard deviation measurements
11) create a subset of the dataset single_df (see list item 9) that includes for each bubject and activity only information about mean and standard deviation
12) by join, in single_df data set in incledet also the column from "activity_labels" that provides the description of the activity 
13) change the single_df data frame measurements column names changing them to lower case and removing -, ( and ) characters. Single_df include now information about suject, a clear description of the activity, let measurements about mean and std dev labeled in a tidy and decriptive way
14) create the aggregate_df dataset that contains the mean of each meuasurement for each activity and each subject
15) write the txt that contains the tidy data set
16) return a list of two data frame. The first data frame named "full" refers to the dataframe that include the test and train dataset merged and cleaned. The second data frame named "aggregated" refers to the dataframe descripted at list item 14, that includes the mean for each subject and activity about mean and std dev measurements
