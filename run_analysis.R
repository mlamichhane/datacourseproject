library(dplyr)

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

#read the features to name the columns
header <- read.table("./UCI HAR Dataset/features.txt", header =  FALSE, stringsAsFactors = FALSE)

#convert the feature names to character vector
header <- as.vector(header$V2)

#since the above vector contains name of the feature, we need to append first 2 column names
#to match the header name list
header <- append(header, c("subject", "activity"),0)

#assign the column names to the dataset
names(train) <- header

#assign descriptive activity names
train$activity <- factor(train$activity, levels=c("1", "2", "3", "4", "5", "6"), labels=c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))

#convert to 
train_df <- tbl_df(train)

train_df <- select(train_df, subject, activity, contains("-mean"), contains("-std"), -contains("meanFreq"))

grp_train <- group_by(train_df, subject, activity)

summarise_each(grp_train, funs(mean))
