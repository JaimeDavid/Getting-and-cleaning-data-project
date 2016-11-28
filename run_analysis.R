#loading required libraries
library(dplyr)
library(reshape2)
#setting the working directory
setwd("C:/Users/Gamers/Dropbox/R/Coursera R/Getting and cleaning data/UCI HAR Dataset")
#loading activity labels and features from data source into r
activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")
#column names for the 2 datasets loaded
names <- c("Key", "Name")
colnames(activity_labels) <- names
colnames(features) <- names

#change working directory to the training set
setwd("C:/Users/Gamers/Dropbox/R/Coursera R/Getting and cleaning data/UCI HAR Dataset/train")
#reading each of the datasets of the train folder into R
subject_train <- read.table("subject_train.txt")
x_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")
#giving names to each of the columns on the y_train  and x_train datasets
colnames(x_train) <- as.character(features$Name)
colnames(y_train) <- "Activity"
colnames(subject_train) <- "Subject"
# giving descriptive labels to each of the activities in the y_train data st witht activity labels data.
y_train <- mutate(y_train, descriptive_label = ifelse(Activity == 1, as.character(activity_labels[1,2]), 
                  ifelse(Activity == 2, as.character(activity_labels[2,2]),
                  ifelse(Activity == 3, as.character(activity_labels[3,2]),
                  ifelse(Activity == 4, as.character(activity_labels[4,2]),
                  ifelse(Activity == 5, as.character(activity_labels[5,2]),
                  ifelse(Activity == 6, as.character(activity_labels[6,2]),0)))))))
#creating a new data frame with all the files using column bind
train_data <- cbind(subject_train, y_train, x_train)
# change the working directory to the test setAR Dataset/test")
setwd("C:/Users/Gamers/Dropbox/R/Coursera R/Getting and cleaning data/UCI HAR Dataset/test")
#reading each of the datasets of the test folder into R
x_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")
subject_test <- read.table("subject_test.txt")
#giving names to each of the columns on the y_train  and x_train datasets
colnames(x_test) <- as.character(features$Name)
colnames(y_test) <- "Activity"
colnames(subject_test) <- "Subject"
# giving descriptive labels to each of the activities in the y_train data set witht activity labels data.
y_test <- mutate(y_test, descriptive_label = ifelse(Activity == 1, as.character(activity_labels[1,2]), 
                  ifelse(Activity == 2, as.character(activity_labels[2,2]),
                  ifelse(Activity == 3, as.character(activity_labels[3,2]),
                  ifelse(Activity == 4, as.character(activity_labels[4,2]),
                  ifelse(Activity == 5, as.character(activity_labels[5,2]),
                  ifelse(Activity == 6, as.character(activity_labels[6,2]),0)))))))
#creating a new data frame with all the files using column bind
test_data <- cbind(subject_test, y_test, x_test)
#merging both the train_data and test_data datasets 
merged_data <- rbind(train_data, test_data)
# extracting the location fo the mean and the standard deviation columns
location <- grep("mean|std", names(merged_data))
# creating the subset data with the data that is requested in the project
subset_data <- cbind(merged_data[,1:3], merged_data[,location])
subset_data <- arrange(subset_data, Subject, Activity)
#dropping the activity column since we dont need it
subset_data <- subset(subset_data, select = -c(Activity))
#create a new tidy data set using reshape 2
#melting the data using the Subject and descriptive label as  identifiers
shape1 <- melt(subset_data, id.vars = c("Subject", "descriptive_label"), na.rm = TRUE)
#creating the tidy dataset using dcast and getting each of the means
tidy_data <- dcast(shape1, Subject + descriptive_label ~ variable, mean)
#set the working directory where we want the file.
setwd("C:/Users/Gamers/Dropbox/R/Coursera R/Getting and cleaning data/Getting and cleaning data project")
#writing the text file 
write.table(tidy_data, "tidy_data.txt")
