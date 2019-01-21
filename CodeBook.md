The tidy dataset includes the following columns:
1) activitydesc -> description of the activity. The variable can assume the following values: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING

2)subject -> subject who performed the activity f. Its range is from 1 to 30.
3) tbodyaccmagmean -> mean of the means for each subject and activity of body acceleration magnitude
4) tbodyaccmagstd -> mean of the standard deviations for each subject and activity of body acceleration magnitude
5) tgravityaccmagmean -> mean of the means for each subject and activity of gravitationalacceleration magnitude
6) tgravityaccmagstd -> mean of the standard deviations for each subject and activity of gravitationalacceleration magnitude
7) tbodyaccjerkmagmean -> mean of the means for each subject and activity of derive in time of the body linear acceleration to obtain Jerk signal
8) tbodyaccjerkmagstd -> mean of the standard deviations for each subject and activity of derive in time of the body linear acceleration to obtain Jerk signal
9) tbodygyromagmean -> mean of the means for each subject and activity of angolar velocity magnitude
10) tbodygyromagstd -> mean of the standard deviations for each subject and activity of angolar velocity magnitude
11) tbodygyrojerkmagmean -> mean of the means for each subject and activity of derive in time of the body angolar velocity to obtain Jerk signal
12) tbodygyrojerkmagstd -> mean of the standard deviations for each subject and activity of derive in time of the body angolar velocity to obtain Jerk signal
13) fbodyaccmagmean -> mean of the means for each subject and activity of fast fourier transform of body acceleration magnitude
14) fbodyaccmagstd -> mean of the standard deviations for each subject and activity of fast fourier transform of body acceleration magnitude
15) fbodybodyaccjerkmagmean -> mean of the means for each subject and activity of fast fourier transform of the body linear acceleration to obtain Jerk signal
16) fbodybodyaccjerkmagstd -> mean of the standard deviations for each subject and activity of fast fourier transform of the body linear acceleration to obtain Jerk signal
17) fbodybodygyromagmean -> mean of the means for each subject and activity of fast fourier transform of body angolar velocity 
18) fbodybodygyromagstd -> mean of the standard deviations for each subject and activity of fast fourier transform of body angolar velocity 
19) fbodybodygyrojerkmagmean -> mean of the means for each subject and activity of fast fourier transform of the body angolar velocity to obtain Jerk signal
20) fbodybodygyrojerkmagstd -> mean of the standard deviations for each subject and activity of fast fourier transform of the body angolar velocity to obtain Jerk signal

the script creates the activitydesc by: cbind y data set with X dataset and then join between activity_labels and the result of previous cbind
the script creates the subjectby: cbind subject data set with X dataset
the script creates all the other variables applying the mean for each subject and activity to all the measurements in dataset X that refer to mean and standard deviation 
