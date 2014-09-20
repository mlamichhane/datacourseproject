Analysis of Human Activity Recognition Using Smartphones Dataset
=================

Introduction
-------------

This repository contains the R script which analyse the dataset from the experiments that have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. The dataset is available from the URL below;

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The dataset is partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. Each of the sets has multiple sets of file with the subject detail, labels and actual dataset.

Following steps were performed for the analysis.

1. Test dataset is merged with it's labels and it's subjects.

2. Training dataset is merged with it's label and it's subjects.

3. Both test and training datasets are merged together to create a single dataset.

4. Each column in the merged dataset is labelled with the list of features provided.

5. Instead of activity number, descriptive activity name is applied to the dataset.

6. Only the mean and standard deviation of each feature are extracted.

7. The average of each variable for each activity and each subject is calculated.

8. A separate tidy dataset is created by first gathering all the measurements and then spreading the activities across the column.


Running the analysis
--------------

###Requirements

1. This analysis requires dplyr and tidyr packages. 


###Running the analysis

1. Download the dataset from the above URL.

2. Extract the zip file in the same folder where run_analysis.R exists. After extracting a zip file, you will see a folder called 'UCI HAR Dataset'.

3. Point the R working directory to the folder where run_analysis.R is found.

4. Run the script in R using a command - source("run_analysis.R").

5. A file named tidy_data.txt is created in R working directory. 