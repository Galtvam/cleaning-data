# CodeBook

## Data

### Origin
The data was loaded from the directory: **./data/UCI HAR Dataset**, which corresponds to the folder obtained after extracting the compressed data. (see README.md)

### Method of Reading
Because the data was stored in **.txt** format it was necessary to do the following sequence of steps:

* First Step: The files were read line by line (read.lines function) receiving a list containing each line (observation) of the dataset as a character array.

* Second Step: Each character array was split (using space as a divisor) and then transformed into a list containing each of the variable values.

* Third Step: The empty strings were removed from lists that resulted from splitting.

* Fourth Step: The dataset was assembled, all resulting split lists became rows from the dataset and had their contents converted to values ​​(as.numeric) that filled the columns.

This way the training and test datasets were read.
