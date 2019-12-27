# $$$$$$$$ #
# DOWNLOAD #
# $$$$$$$$ #

file_name <- "./data/getting_and_cleaning.zip"

if (!file.exists(file_name)){
  URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(URL, file_name)
}   

if (!file.exists("./data/UCI-HAR-Dataset")) { 
  unzip(file_name, exdir= "./data") 
  file.rename("./data/UCI HAR Dataset","./data/UCI-HAR-Dataset")
}



# $$$$$$$$$ #
# FUNCTIONS #
# $$$$$$$$$ #

# Returns a dataset that contains the mean and standard deviation for each variable.
mean_and_sd <- function(data){
    measured_data <- data.frame( row.names= c("Mean", "Std Dev") )
    for( i in seq_len( length( names(data) ) ) ){
        measured_data[1,i] <- mean( as.numeric(data[,i]) )
        measured_data[2,i] <- sd( as.numeric(data[,i]) )
    }
    names(measured_data) <- names(data)
    measured_data
}

# Returns a dataset containing the average of each variable for each activity per subject.
mean_per_subject_and_activity <- function(data, subjects, activities){
    last_col <- ncol(data)
    penultimate_column <- ncol(data) -1
    measured_activities_per_subject <- data.frame()
    n <- 0
    for(suj in subjects){
        logic_subject_split <- data[,penultimate_column] == suj
        suj_data <- data[logic_subject_split, ]
        for( activity in activities){
            n <- n + 1
            logic_activity_oF_suj <- suj_data[, last_col] == activity
            activity_of_suj_data <- suj_data[logic_activity_oF_suj, ]
            measured_activities_per_subject[n,1] <- suj
            measured_activities_per_subject[n,2] <- activity
            for( i in seq_len( length( names(activity_of_suj_data) )-2 )){
                measured_activities_per_subject[n,(2+i)] <- mean( as.numeric(activity_of_suj_data[,i]) )
            }
        }
    }
    variables_names <- names(data)[-penultimate_column:-last_col]
    names(measured_activities_per_subject) <- c( c("Subject", "Activity"), variables_names )
    measured_activities_per_subject
}


# $$$$$$$$$$$$$$$$$$$$$ #
# LOADING COLUMNS NAMES #
# $$$$$$$$$$$$$$$$$$$$$ #

features_path <- "./data/UCI-HAR-Dataset/features.txt"
col_labels <- read.table(features_path)
clean_col_labels <- col_labels[,2]

clean_col_labels <- gsub("Acc", "Accelerometer", clean_col_labels)
clean_col_labels <- gsub("Gyro", "Gyroscope", clean_col_labels)
clean_col_labels <- gsub("BodyBody", "Body", clean_col_labels)
clean_col_labels <- gsub("Mag", "Magnitude", clean_col_labels)
clean_col_labels <- gsub("^t", "Time", clean_col_labels)
clean_col_labels <- gsub("^f", "Frequency", clean_col_labels)
clean_col_labels <- gsub("tBody", "TimeBody", clean_col_labels)
clean_col_labels <- gsub("-mean()", "Mean", clean_col_labels)
clean_col_labels <- gsub("-std()", "STD", clean_col_labels)
clean_col_labels <- gsub("-freq()", "Frequency", clean_col_labels)
clean_col_labels <- gsub("angle", "Angle", clean_col_labels)
clean_col_labels <- gsub("gravity", "Gravity", clean_col_labels)



# $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ #
# DATA READING AND ASSEMBLY OF TEST DATASET #
# $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ #

###########################
# READING ACTIVITY LABELS #
###########################

y_test_path <- "./data/UCI-HAR-Dataset/test/y_test.txt"
test_labels <- readLines(y_test_path)

descriptive_test_labels <- gsub("1", tolower("WALKING"), test_labels)
descriptive_test_labels <- gsub("2", tolower("WALKING_UPSTAIRS"), descriptive_test_labels)
descriptive_test_labels <- gsub("3", tolower("WALKING_DOWNSTAIRS"), descriptive_test_labels)
descriptive_test_labels <- gsub("4", tolower("SITTING"), descriptive_test_labels)
descriptive_test_labels <- gsub("5", tolower("STANDING"), descriptive_test_labels)
descriptive_test_labels <- gsub("6", tolower("LAYING"), descriptive_test_labels)


#######################
# READING OF SUBJECTS #
#######################

subject_test_path <- "./data/UCI-HAR-Dataset/test/subject_test.txt"
test_subject <- readLines(subject_test_path)


#############################################
# READING OBSERVATIONS AND DATASET CREATION #
#############################################

x_test_path <- "./data/UCI-HAR-Dataset/test/X_test.txt"
test_dataset <- read.table(x_test_path)

names(test_dataset) <- clean_col_labels
test_dataset$subject <- test_subject
test_dataset$activity <- descriptive_test_labels

# "test_dataset" match final data set with test data



# $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ #
# DATA READING AND ASSEMBLY OF TRAINING DATASET #
# $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ #

###########################
# READING ACTIVITY LABELS #
###########################

y_train_path <- "./data/UCI-HAR-Dataset/train/y_train.txt"
train_labels <- readLines(y_train_path)

descriptive_train_labels <- gsub("1", tolower("WALKING"), train_labels)
descriptive_train_labels <- gsub("2", tolower("WALKING_UPSTAIRS"), descriptive_train_labels)
descriptive_train_labels <- gsub("3", tolower("WALKING_DOWNSTAIRS"), descriptive_train_labels)
descriptive_train_labels <- gsub("4", tolower("SITTING"), descriptive_train_labels)
descriptive_train_labels <- gsub("5", tolower("STANDING"), descriptive_train_labels)
descriptive_train_labels <- gsub("6", tolower("LAYING"), descriptive_train_labels)


#######################
# READING OF SUBJECTS #
#######################

subject_train_path <- "./data/UCI-HAR-Dataset/train/subject_train.txt"
train_subject <- readLines(subject_train_path)


#############################################
# READING OBSERVATIONS AND DATASET CREATION #
#############################################

x_train_path <- "./data/UCI-HAR-Dataset/train/X_train.txt"
train_dataset <- read.table(x_train_path)

names(train_dataset) <- clean_col_labels
train_dataset$subject <- train_subject
train_dataset$activity <- descriptive_train_labels

# "train_dataset" match final data set with training data



# $$$$$$$$$$$$$$$$$$$$$$$$$$$ #
# FINAL DATA (TRAINING + TEST) #
# $$$$$$$$$$$$$$$$$$$$$$$$$$$ #

#########################################
# 10299x563 DATASET CONTAINING ALL DATA #
#########################################

full_data <- rbind(train_dataset, test_dataset, by= names(train_dataset))
full_data <- full_data[-10300,] #remove last row with column names

# "full_data" match the dataset with all the data

#############################################
# 10299x88 DATASET CONTAINING FILTERED DATA #
#############################################

filtered_full_data <- full_data[ , grepl("subject|activity|Mean|STD", names(full_data))] 
# take only subject, activity, mean and std columns.



# $$$$$$$$ #
# ANALYSIS #
# $$$$$$$$ #

####################################################################
# 2x86 DATASET WITH MEAN AND STANDARD DEVIATION FOR EACH VARIABLE #
####################################################################

mean_and_sd_analysis <- mean_and_sd(full_data[, -562:-563]) #remove subject and activity columns



##################################################################################
# 180x88 DATASET CONTAINING THE AVERAGE OF EACH VARIABLE BY ACTIVITY FOR SUBJECT #
##################################################################################

activities <- names(table(filtered_full_data[,88]))
mean_per_subject_and_activity_analysis <-  mean_per_subject_and_activity(filtered_full_data, 1:30, activities)

