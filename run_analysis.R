#load required packages
library(dplyr)
library(tidyr)

#First read the subject for test data
test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header =  FALSE, stringsAsFactors = FALSE)
names(test) <- c("subject")

#read the activity for test data
testy <- read.table("./UCI HAR Dataset/test/y_test.txt", header =  FALSE, stringsAsFactors = FALSE)
names(testy) <- c("activity")

#read the test data
testx <- read.table("./UCI HAR Dataset/test/x_test.txt", header =  FALSE, stringsAsFactors = FALSE)

#bind test data with subject and activity
test <- cbind(test, testy, testx)

#clean-up some memory
rm(testx)
rm(testy)

#read the subject for training data
train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE, stringsAsFactors = FALSE)
names(train) <- c("subject")

#read the activity for training data
trainy <- read.table("./UCI HAR Dataset/train/y_train.txt", header =  FALSE, stringsAsFactors = FALSE)
names(trainy) <- c("activity")

#read the training data
trainx <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE, stringsAsFactors = FALSE)

#bind training data with subject and activity
train <- cbind(train, trainy, trainx)

#bind the training and test dataset
train <- rbind(train, test)

#clean-up some memory
rm(trainx)
rm(trainy)
rm(test)

#read the features in order to name the columns
header <- read.table("./UCI HAR Dataset/features.txt", header =  FALSE, stringsAsFactors = FALSE)

#convert the feature names to character vector
header <- as.vector(header$V2)

#since the above vector contains only name of the feature, we need to append first 2 column names
#to match the header name list
header <- append(header, c("subject", "activity"),0)

#assign the column names to the dataset
names(train) <- header

#assign descriptive activity names
train$activity <- factor(train$activity, levels=c("1", "2", "3", "4", "5", "6"), labels=c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))

#create a data frame table (using dplyr package) 
train_df <- tbl_df(train)

#clean-up some memory
rm(header)
rm(train)

#select only the mean and standard deviation for each measurement
train_df <- select(train_df, subject, activity, contains("-mean"), contains("-std"), -contains("meanFreq"))

#group data by subject and activity
grp_train <- group_by(train_df, subject, activity)

#calculate average of each measurement 
sum_grp_train <- summarise_each(grp_train, funs(mean))

#generate a tidy data set by first gathering all the measurements
#and then spreading the activities across the column
tidy_data <- sum_grp_train%>%gather(feature, average_value, 3:68)%>%spread(activity, average_value)

#export tidy_data set to an external file
write.table(tidy_data,file="tidy_data.txt", row.names= FALSE)

#clean-up some memory
rm(train_df)
rm(grp_train)
rm(sum_grp_train)