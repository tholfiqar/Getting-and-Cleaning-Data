CodeBook
---------------------------------------------------------------
This document is the CodeBook for the tidy dataset.

##Data source

This dataset is derived from the "Human Activity Recognition Using Smartphones Data Set" which was originally made avaiable here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data set used could be downloaded from the following link <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>. 


##Transformations

Those transformations were performed on the original dataset:


- `subject_train.txt` is read into `subject_train`.
- `subject_test.txt` is read into `subject_test`.
- The subjects in training and test are merged to form `subject`.


- `y_train.txt` is read into `activity_train`.
- `y_test.txt` is read into `activity_test`.
- The activities in training and test are merged to form `activity`.

- `X_train.txt` is read into `features_train`.
- `X_test.txt` is read into `features_test`.
- The features in training and test are merged to form `features`.

- `features.txt` is read into `features_names`.
- `activity_labels.txt` is read into `activity_labels`.

- Changed the column name of the subject table to `subject`.
- Changed the column name of the activity table to `activity`.
- Changed the column name of the features table to match the names in features_names.
- `features`, `activity` and `subject` are merged to form `completeData`.


- The name of the features are set in `features` from `features_names`.
- Indices of columns that contain std or mean, activity and subject are taken into `std_mean` .


- `Data` is created with data from columns in `std_mean`.

- `Activity` column in `Data` is updated with descriptive names of activities taken from `activity_labels`. 

- `Activity` column is expressed as a factor variable.

- Variable names in `Data`  'Acc', 'Gyro', 'BodyBody', 'Mag', 't', 'f','tBody','-mean()','-std()','-freq()','angle', 'gravity' are replaced with labels  'Accelerometer', 'Gyroscpoe', 'Body', 'Magnitude', 'Time', 'Frequency', 'TimeBody', 'Mean', 'STD', 'Frequency', 'Angle', 'Gravity'.

- `tidyData` is created as a set with average for each activity and subject of `Data`. 

- The data in `tidyData` is written into `Tidy.csv`.

## The tidy data set

The output file is `Tidy.csv` which is a space-delimited value file. 