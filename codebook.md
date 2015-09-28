#Human Activity Recognition Using Smartphones Dataset
Version 1.0#
#Human Activity Recognition Using Smartphones Dataset
Version 1.0#

#Original Readme.md#
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.  For each record it is provided:- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

#This exercise# combined the following datasets into 1 dataset :
- 'train/'test/ subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/'test/X_train.txt': Training set.
- 'train/'test/y_train.txt': Training labels.

#Activity Codes to Descriptive Text#
The Activity Codes column in file y_test.txt, labelled "V1" , was converted from a 1-byte alphabetic code to the text descriptive column called "activity" using the values in activity_labels.txt<br>
1 WALKING<br>
2 WALKING_UPSTAIRS<br>
3 WALKING_DOWNSTAIRS<br>
4 SITTING<br>
5 STANDING<br>
6 LAYING<br>

#Data columns filter#
The 561 columns in file X_test.txt, and X_train.txt, were renamed using the features.txt file. <br>
I then removed all the columns that did not contain mean or standard deviation measures.  This changed the dataset from 561 columns (features) to 79. 


#Column Details#
1)time_BodyAcc_mean<br>
2)time_BodyAcc_std<br>
3)time_GravityAcc_mean<br>
4)time_GravityAcc_std<br>
5)time_BodyAccJerk_mean<br>
6)time_BodyAccJerk_std<br>
7)time_BodyGyro_mean<br>
8)time_BodyGyro_std<br>
9)time_BodyGyroJerk_mean<br>
10)time_BodyGyroJerk_std<br>
11)time_BodyAccMag_me<br>
12)time_BodyAccMag_s<br>
13)time_GravityAccMag_me<br>
14)time_GravityAccMag_s<br>
15)time_BodyAccJerkMag_me<br>
16)time_BodyAccJerkMag_s<br>
17)time_BodyGyroMag_me<br>
18)time_BodyGyroMag_s<br>
19)time_BodyGyroJerkMag_me<br>
20)time_BodyGyroJerkMag_s<br>
21)frequency_BodyAcc_mean<br>
22)frequency_BodyAcc_std<br>
23)frequency_BodyAcc_meanFreq<br>
24)frequency_BodyAccJerk_mean<br>
25)frequency_BodyAccJerk_std<br>
26)frequency_BodyAccJerk_meanFreq<br>
27)frequency_BodyGyro_mean<br>
28)frequency_BodyGyro_std<br>
29)frequency_BodyGyro_meanFreq<br>
