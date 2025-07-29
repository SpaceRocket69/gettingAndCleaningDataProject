# Getting and Cleaning Data - Course Project

## Overview

This project is part of the Coursera course "Getting and Cleaning Data."
The purpose is to take raw data collected from the accelerometers and gyroscopes of a Samsung Galaxy S smartphone
and transform it into a tidy data set that can be used for further analysis.
The data records activities of subjects performing various movements, such as walking or sitting.

## Data Source

The original dataset is provided by the UCI Machine Learning Repository:

**[Human Activity Recognition Using Smartphones Data Set](https://archive.ics.uci.edu/ml/datasets/human+activity+recognition+using+smartphones)**

- The data was collected from 30 subjects performing six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).
- Each observation includes measurements from embedded smartphone sensors.

## Files Included

- `run_analysis.R`: The script that performs the full data cleaning and transformation process.
- `CodeBook.md`: Describes the variables, data structure, units, and transformation steps.
- `observations.txt`: The final tidy dataset containing all unaggregated data.
- `summary_data.txt`: The final tidy dataset containing the average of each variable for each activity and each subject.

## How `run_analysis.R` Works

1. **Downloads and unzips** the UCI HAR Dataset.
2. **Loads** the training and test data sets, including subject and activity labels.
3. **Merges** the training and test data into one combined data frame.
4. **Filters** the columns to keep only measurements on the mean and standard deviation.
5. **Labels** the data with descriptive activity names instead of numeric codes.
6. **Creates a second tidy data set**, which contains the average of each variable, grouped by subject and activity.

## Output

The script produces two final tidy data files called:

- `observations.txt`
- `summary_data.txt`

## Requirements

- R (version ≥ 3.6)
- Packages: `dplyr`