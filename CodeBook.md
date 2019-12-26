# Data

### Origin
The data was loaded from the directory: **./data/UCI HAR Dataset**, which corresponds to the folder obtained after extracting the compressed data. (see [README.md](/README.md))

### Method of Reading
Because the data was stored in **.txt** format it was necessary to do the following sequence of steps:

* **First Step:** The files were read line by line (read.lines function) receiving a list containing each line (observation) of the dataset as a character array.

* **Second Step:** Each character array was split (using space as a divisor) and then transformed into a list containing each of the variable values.

* **Third Step:** The empty strings were removed from lists that resulted from splitting.

* **Fourth Step:** Columns name read from **features.txt** file.

* **Sixth Step:** The number in front of the column names has been removed.

* **Seventh Step:** The activity labels were loaded for the training and test set.

* **Eighth Step:** The numerical identification of the activities has been replaced by descriptive names.

* **Ninth Step:** The dataset was assembled, all resulting split lists became rows from the dataset and had their contents converted to values ​​(**as.numeric()**) that filled the columns.

This way the training and test datasets were read.

### Full Dataset
The complete dataset was assembled through the **cbind()** of training and test data.


# Functions and Analysis

### Mean and Standard Deviation for each variable
The result of this analysis was obtained through the function **mean_and_sd** that receives as a parameter a data set that contains only numeric values.

* **mean_and_sd()** - This results in a 2xN dataset where there are 2 rows and N columns (N is the same as the number of columns in the original dataset).

### Average of each Variable by Activity per Subject
The result of this analysis was obtained through the function **mean_per_subject_and_activity**.

* **mean_per_subject_and_activity** - This function receives three parameters: the dataset to be analyzed, a list with the name of all subjects and a list with the name of all activities to be analyzed. Finally returns an NxM dataset where N = (number of Subjects * the number of activities) and M is the same number of columns as the original dataset.


# Important Variables

### test_dataset
It has the dataset with the test data.

### train_dataset
It has the dataset with the training data.

### full_dataset
Has combined test + training dataset.

### mean_and_sd_analysis
It has the dataset containing the mean and standard deviation of each variable of full_dataset.

### mean_per_subject_and_activity_analysis
It has the data set that contains the average of all variables for each activity performed by each subject.