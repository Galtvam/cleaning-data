
# $$$$$$$$$ #
# FUNCTIONS #
# $$$$$$$$$ #

# Returns a list containing the name of the labels passed as a parameter.
clear_names <- function(labels){
    new_labels <- list()
    for(i in seq_len(length(labels)) ){
        new_labels[i] <- labels[[i]][2]
    }
    new_labels
}

# Returns a logical vector contains the indices where the value is not empty.
empty_check <- function(x){
    !(nchar(x)==0)
}

# Returns a data set created with the list of strings passed as a parameter.
clean_data <- function(data){
    for(i in seq_len(length(data)) ){
        string_splitted <- strsplit(data[i], " ")[[1]]
        empty_remove <- sapply(string_splitted, empty_check)
        string_cleaned <- as.list( as.numeric(string_splitted[empty_remove]) )
        if(i == 1){
            new_data <- data.frame(string_cleaned)
        }else{
            new_data[i,] <- string_cleaned
        }
    }
    new_data
}

# Returns a 2x561 data set that contains the mean and standard deviation for each variable.
mean_and_sd <- function(data){
    measured_data <- data.frame( row.names= c("Mean", "Std Dev") )
    for( i in seq_len( length( names(data) ) ) ){
        measured_data[1,i] <- mean( as.numeric(data[,i]) )
        measured_data[2,i] <- sd( as.numeric(data[,i]) )
    }
    names(measured_data) <- names(data)
    measured_data
}

# Returns a 180 x 563 dataset containing the average of each variable for each activity per subject.
mean_per_subject_and_activity <- function(data, subjects, activities){
    measured_activities_per_subject <- data.frame()
    n <- 0
    for(suj in subjects){
        logic_subject_split <- data[,562] == suj
        suj_data <- data[logic_subject_split, ]
        for( activity in activities){
            n <- n + 1
            logic_activity_oF_suj <- suj_data[, 563] == activity
            activity_of_suj_data <- suj_data[logic_activity_oF_suj, ]
            measured_activities_per_subject[n,1] <- suj
            measured_activities_per_subject[n,2] <- activity
            for( i in seq_len( length( names(activity_of_suj_data) )-2 )){
                measured_activities_per_subject[n,(2+i)] <- mean( as.numeric(activity_of_suj_data[,i]) )
            }
        }
    }
    variables_names <- names(data)[-562:-563]
    names(measured_activities_per_subject) <- c( c("Subject", "Activity"), variables_names )
    measured_activities_per_subject
}


# $$$$$$$$$$$$$$$$$$$$$ #
# LOADING COLUMNS NAMES #
# $$$$$$$$$$$$$$$$$$$$$ #

features_path <- "./data/UCI-HAR-Dataset/features.txt"
col_labels <- readLines(features_path)
splitted_col_labels <- strsplit(col_labels, " ")

clean_col_labels <- clear_names(splitted_col_labels)



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
test_data <- readLines(x_test_path)
test_dataset <- clean_data(test_data)

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
train_data <- readLines(x_train_path)
train_dataset <- clean_data(train_data)

names(train_dataset) <- clean_col_labels
train_dataset$subject <- train_subject
train_dataset$activity <- descriptive_train_labels

# "train_dataset" match final data set with training data



# $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ #
# FINAL DATA ASSEMBLY (TRAINING + TEST) #
# $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ #

full_dataset <- rbind(train_dataset, test_dataset, by= names(train_dataset))
full_dataset <- full_dataset[-10300,] #remove last row with column names

# "full_dataset" match the dataset with all the data



# $$$$$$$$ #
# ANALYSIS #
# $$$$$$$$ #

######################################################################
# 2x561 DATASET WITH MEDIA AND STANDARD DEVIATION FOR EVERY VARIABLE #
######################################################################

mean_and_sd_analysis <- mean_and_sd(full_dataset[, -562:-563]) #remove subject and activity columns



###################################################################################
# 180x563 DATASET CONTAINING THE AVERAGE OF EACH VARIABLE BY ACTIVITY PER SUBJECT #
###################################################################################

activities <- names(table(full_dataset[,563]))
mean_per_subject_and_activity_analysis <-  mean_per_subject_and_activity(full_dataset, 1:30, activities)

