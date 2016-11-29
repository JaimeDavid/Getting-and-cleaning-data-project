## Getting and cleaning data course project

* The data for this course project was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


The idea behind the course project for getting and cleaning data was to use multiple data sets that we needed to clean and modify 
in order for us to create a tidy dataset with the information that was required, the procedure that I used to complete the project is as follows:

* I used the dplyr and reshape libraries and the base functions in R for the completion of this project.

* The first thing I did was look at the structure of the data of each of the datasets to get a sense of what we are working with head function on each dataset

* I started with the train dataset and then moved on to the test dataset seeing that they had the same column length but diferent row length, so i decided that i needed to modify the dataset and then join them all together.

* First I gave names to each of the features and descriptive labels columns, then I loaded the x_train, subject_train and y_train into R.

* Looking at the dimension of the x_train dataset and the features dataset plus the information in the readme file I concluded that the features dataset was the column names for the x_ train dataset, using the appropiate function colnames() I named each of the columns in the x_train dataset using the information on the features dataset, then I gave column names for the y_train ("Activity") and subject_train ("Subject") datasets

* I created the descriptive label column that was needed in the y_train dataset by using the mutate function and the information from the activity_labels dataset.

* I create the dataset train_data by binding the columns cbind(), using the subject_train, y_train and x_train datasets.

* I followed the same steps for the test datasets, and finally created the test_data dataset.

* Having the 2 datasets I created the merged_data datasets using rbind() since they haved the same number of columns in the same order but different number of rows

* The assignment wants us to find every column in the merged_data dataset that has the mean and std (standard deviation) for each measurement, I used the grep function to find the location of each column within the dataset.

* After I found the location of the information required within the merged_data dataset I  created a new dataset called subset_Data using cbind() and subsetting the information that I required, following that I arranged the data, and dropped the activity column since it isn't needed.

* Now we create the tidy_data dataset, first I start creating a dataset called shape_1 using the melt function from the reshape library, using the subset_data dataset and using id variables "Subject" and "Descriptive Label".

* Now I use the dcast function on the shape1 dataset, using the appropiate syntax so the "Subject" and "descriptive_label"
 as variables and the function mean whic was asked.

* Now we change the working directory to the place location we want the file saved and use the write.table function to get the file.
