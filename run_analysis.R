library(dplyr)

# Download and unzip the Data set
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- "uciHar.zip"
download.file(fileUrl, fileName, method = "curl")
unzip(fileName)

# Read the data into data frames
  # Feature Names
featureNames <- read.table("UCI HAR Dataset/features.txt", header = FALSE)
  # Activity Labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
  # Test Data
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activityTest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
featureTest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
  # Train Data
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
featureTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

# Merge training and test data sets
subjectData <- rbind(subjectTest, subjectTrain)
activityData <- rbind(activityTest, activityTrain)
featureData <- rbind(featureTest, featureTrain)

# Set names to variables
names(subjectData) <- "Subject"
names(activityData) <- "Activity"
names(featureData) <- featureNames$V2

# Merge all data to create one data set
allData <- cbind(subjectData, activityData, featureData)

# Extract only the measurements on the mean and standard deviation for each measurement
meanAndStd <- allData %>% select(Subject, Activity, contains("mean"), contains("std"))

# Use descriptive activity names to name the activities in the data set
meanAndStd$Activity <- activityLabels[meanAndStd$Activity, 2]

# Label the data set with descriptive variable names
names(meanAndStd) <- gsub("Acc", "Accelerometer", names(meanAndStd))
names(meanAndStd) <- gsub("Gyro", "Gyroscope", names(meanAndStd))
names(meanAndStd) <- gsub("BodyBody", "Body", names(meanAndStd))
names(meanAndStd) <- gsub("Mag", "Magnitude", names(meanAndStd))
names(meanAndStd) <- gsub("^t", "Time", names(meanAndStd))
names(meanAndStd) <- gsub("^f", "Frequency", names(meanAndStd))
names(meanAndStd) <- gsub("tBody", "TimeBody", names(meanAndStd))
names(meanAndStd) <- gsub("-mean()", "Mean", names(meanAndStd), ignore.case = TRUE)
names(meanAndStd) <- gsub("-std()", "Std", names(meanAndStd), ignore.case = TRUE)
names(meanAndStd) <- gsub("-freq()", "Frequency", names(meanAndStd), ignore.case = TRUE)
names(meanAndStd) <- gsub("angle", "Angle", names(meanAndStd))
names(meanAndStd) <- gsub("gravity", "Gravity", names(meanAndStd))

# Create a second, independent tidy data set with the average of each variable for each activity and each subject
tidyData <- meanAndStd %>%
  group_by(Subject, Activity) %>%
  summarise_all(funs(mean))
write.table(tidylData, file = "tidyData.txt", row.names = FALSE)
