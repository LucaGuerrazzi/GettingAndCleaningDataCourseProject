library(data.table)
library(dplyr)

run_analisys <- function() {
        #get the full list of flle in "UCI HAR Dataset" folder tree
        full_file_list <- list.files(path=".\\CleaningData\\CoursePrj\\UCI HAR Dataset", pattern = "^[^R](.*)[^o]+.txt$", full.name=TRUE, recursive = TRUE)
        #get the list of the only necessary file listed in full_file_list
        full_file_list <- full_file_list[grep("(/X_)|(/y_)|(/subject_)|(/activity_)|(/features\\.)",full_file_list)]

        #create a list of all the dataframes required for the elaboration.
        #they are: "activity_labels","subject_test","X_test","y_test","subject_train","X_train","y_train", "features.txt"
        df_list_before_merge <- list()
        df_name_list_before_merge <- vector()
        for (file in full_file_list) {
                 df_name <- sub(".*/", "", sub(".txt$", "", file))
                 tmp_df <- fread(file)
                 df_list_before_merge[[df_name]] <- tmp_df
                 df_name_list_before_merge <- c(df_name_list_before_merge,df_name)
        }
        
        df_name_list_after_merge <- unique(sub("(_test|_train)$","",df_name_list_before_merge))

        #creates a list of dataframe. each dataframe in obtained binding
        #the related _test and the _train dataframes. Eg. data frame labeled
        #as X is created by rbind(X_test, X_train)
        df_list_after_merge <- list()
        for (df_name in df_name_list_after_merge) {
                if(df_name=="activity_labels" | df_name=="features") {
                        #activity_labels and feature do not require any merge
                        df_list_after_merge[[df_name]] <- df_list_before_merge[[df_name]]
                } else {
                        df_test_name <- paste(df_name,"_test",sep="")
                        df_train_name <- paste(df_name,"_train",sep="")
                        df_list_after_merge[[df_name]] <- rbind(df_list_before_merge[[df_test_name]],df_list_before_merge[[df_train_name]])
                }
        }
        
        #rename V1 column of subject dataframe in "subject"
        colnames(df_list_after_merge[["subject"]]) <- "subject"
        #rename V1 column of y dataframe in "activity"
        colnames(df_list_after_merge[["y"]]) <- "activity"
        #rename all data frame X column with the values of "features" data frame
        colnames(df_list_after_merge[["X"]]) <- as.vector(df_list_after_merge[["features"]]$V2)
        #add column "subject" of data frame "subject" to data frame "x"
        df_list_after_merge[["X"]] <- cbind(df_list_after_merge[["subject"]],df_list_after_merge[["X"]])
        #add column "activity" of data frame "y" to data frame "x". The new dataframe is named
        #single_df and it merges the training and the test sets in one data set.
        #---------------------------------------------------
        #single_df satisfy the first request of the project assignment
        single_df <- cbind(df_list_after_merge[["y"]],df_list_after_merge[["X"]])
        #---------------------------------------------------

        single_df_names <- names(single_df)
        #vector that contain column position related to subject, activity, mean and standard deviation
        mean_std_df_labels <- single_df_names[c(1,2,grep("(-mean\\(\\)$)|(-std\\(\\)$)",single_df_names))]
        #---------------------------------------------------
        #subset of single_df data frame that includes only information about mean and standard deviation
        #single_df satisfy the second request of the project assignment
        single_df <- subset(single_df,select = mean_std_df_labels)
        #---------------------------------------------------
        
        #change the column name of df_list_after_merge[["activity_labels"]] data frame
        #from V1 e V2 to "activity" and "activityDesc
        colnames(df_list_after_merge[["activity_labels"]]) <- c("activity","activityDesc")
        #creation of a new column in single_df that include the activity related to the observation
        #---------------------------------------------------
        #descriptive activity names are used to name the activities in the data set
        #single_df satisfy the third request of the project assignment
        single_df <- inner_join(y = single_df, x = df_list_after_merge[["activity_labels"]], by = "activity")
        single_df$activity <- NULL
        #---------------------------------------------------
        #change of single_df data frame measurements columns name by
        #change the string to lower case and removing -, ( and ) characters
        #---------------------------------------------------
        #the data set is labeled with descriptive variable names.
        #single_df satisfies the fourth request of the project assignment
        #---------------------------------------------------
        colnames(single_df) <- tolower(gsub("(-)|(\\(\\))$","",names(single_df)))

        #---------------------------------------------------
        #aggregate_df reports the average of each variable for each activity and each subject
        #single_df satisfies the fifth request of the project assignment
        aggregate_df <- single_df %>% group_by(activitydesc, subject)  %>% summarize_all(funs(mean))
        #---------------------------------------------------
        
        #csv that contains the tidy data set
        write.csv(aggregate_df,file=".\\CleaningData\\CoursePrj\\tidi_dataset.csv")
        
        #the script return a list of two data frame. The first data frame named "full" refers to the dataframe that include
        #the test and train dataset merged anc cleaned
        #The second data frame named "aggregated" refers to the dataframe that include the mean by subject and activity 
        #of mean and std dev measurements
        result <- list()
        result[["full"]] <- single_df
        result[["aggregated"]] <- aggregate_df
        
        result
}