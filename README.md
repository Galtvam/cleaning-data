# Cleaning Data Project
This work was developed as the final project of the course [**Getting and Cleaning Data**](https://www.coursera.org/learn/data-cleaning?specialization=jhu-data-science) offered by **The Johns Hopkins University** through the **Coursera** platform.

## Abstract about the data 
Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.
As experiências foram realizadas com um grupo de 30 voluntários com idade entre 19 e 48 anos. Cada pessoa realizou seis atividades (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) usando um smartphone (Samsung Galaxy S II) na cintura. Usando seu acelerômetro e giroscópio embutido, capturamos a aceleração linear 3-axial e a velocidade angular 3-axial a uma taxa constante de 50Hz.
For more datails access [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
**Obs: All information was collected from the official repository.**

## Data Organization
The experiment data were separated into two large sets, one for training and one for testing there are 30 individuals who performed 6 different types of activities and for each observation, there are 561 variables that keep normalized values ​​ranging from 1 to -1.
For more details consult the [README](/data/UCI HAR Dataset/README.txt) of the data.

## Project Proposal
The goal of the project is to deliver three artifacts, the first is the complete dataset containing the training and test data, with the correctly named columns and the activities with descriptive names, the second and third artifacts consist of analyzes that must be performed on the full dataset:
* Second artifact: A data set that contains the mean and standard deviation of each of the 561 variables.
* Third artifact: A data set containing the average of each of the 561 variables, segmented by the activity to which they belong and which subject performed them.

## "run_analysis.R" Script
This script completes all the steps described in [CodeBook.md](/CodeBook.md), reads all data, assembles all datasets (training, testing, full) and performs the analysis described in [Project Proposal](#Project-Proposal).

## Finished Datasets
In the folder [**data**](/data) are the three project artifacts, exported in **.csv** format, they are:
* **First artifact**: ["UCI_HAR_full_data.csv"](/data/UCI_HAR_full_data.csv)
* **Second artifact**: ["mean_and_sd_analysis.csv"](/data/mean_and_sd_analysis.csv)
* **Third artifact**: ["mean_activity_subject_analysis.csv"](/data/mean_activity_subject_analysis.csv)
