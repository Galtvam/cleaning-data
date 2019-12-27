# Data

### Origin
The data was loaded from the directory: **./data/UCI-HAR-Dataset**, which corresponds to the folder obtained after extracting the compressed data. (see [README.md](/README.md))

### Method of Reading
Because the data was stored in **.txt** format it was necessary to do the following sequence of steps:

* **First Step:** The files were read using read.table function.

* **Second Step:** Columns name read from **features.txt** file.

* **Third Step:** The number in front of the column names has been removed.

* **Fourth Step:** Columns name are replaced by descriptive names.

* **Fifth Step:** The activity labels were loaded for the training and test set.

* **Sixth Step:** The numerical identification of the activities has been replaced by descriptive names.

This way the training and test datasets were read.

### Full Dataset
The complete dataset was assembled through the **cbind()** of training and test data.

### Filtered Full Data
Data filtered by subject, activity, and columns that have "mean" or "standard deviation" in their names.


# Functions and Analysis

### Mean and Standard Deviation for each variable
The result of this analysis was obtained through the function **mean_and_sd** that receives as a parameter a data set that contains only numeric values.

* **mean_and_sd()** - This results in a 2xN dataset where there are 2 rows and N columns (N is the same as the number of columns in the original dataset).

### Average of each Variable by Activity per Subject
The result of this analysis was obtained through the function **mean_per_subject_and_activity**.

* **mean_per_subject_and_activity** - This function receives three parameters: the dataset to be analyzed, a list with the name of all subjects and a list with the name of all activities to be analyzed. Finally returns an NxM dataset where N = (number of Subjects * the number of activities) and M is the same number of columns as the original dataset.


# Important Variables
* **test_dataset** - It has the dataset with the test data.

* **train_dataset** - It has the dataset with the training data.

* **full_dataset** - Has combined test + training dataset.

* **mean_and_sd_analysis** - It has the dataset containing the mean and standard deviation of each variable of full_dataset.

* **mean_per_subject_and_activity_analysis** - It has the data set that contains the average of all variables for each activity performed by each subject.