# Codebook for the Getting and Cleaning Data Project.

This codebook describes the variables, units of measurement, and data transformations
performed on the UCI HAR Dataset to produce the two tidy datasets used in this project.

This repo contains two data sets:
- df_subset
- summary


### Variables

- df_subset

This dataset contains the colums:
  - "subject": Which subject performed the activity
  - "activity": Which activity was performed
  - "training": Binary value that specifies which data record is the source.
  - Other variables: Numeric features representing either the mean or standard deviation of sensor
    signals from the smartphone's accelerometer and gyroscope, along X, Y, and Z axes.
    Variable names include:
    - Prefix `t` for time-domain signals
    - Prefix `f` for frequency-domain signals
    - Components like `BodyAcc`, `GravityAcc`, `Gyro`, `Jerk` describe the source or type of signal
    - Suffixes `-X`, `-Y`, `-Z` indicate the axis

- summary

This dataset contains the same variables as `df_subset`, but each value represents
the average of that measurement for each combination of subject and activity.



### Units of measurement

Accelerometer signals (BodyAcc, GravityAcc, etc.)
- Measured in g (standard gravity units)
- 1g ≈ 9.81 m/s²

Gyroscope signals (BodyGyro, etc.)
- Measured in radians/second

Magnitude signals (...Mag)
- Also in g (for acceleration) or radians/sec (for angular velocity), depending on the original signal

Angles (e.g., angle(tBodyAccMean,gravity)):
- Measured in radians

Domain Indicators:
- t prefix (e.g., tBodyAcc): time-domain signal (raw sensor readings over time)
- f prefix (e.g., fBodyAcc): frequency-domain signal (obtained via Fast Fourier Transform)


### Explanation of mutations/summarizations

The summarized data set represents the mean of each variable, aggregated by subject and activity.


### Data Processing and Transformations

- Read in and labeled training and test sets, including sensor measurements, activity labels, and subject IDs
- Added subject and activity columns to the measurement data frame both for the training and test data
- Added a binary column "training" to indicate the data source (training vs. test)
- Merged training and test sets into a single dataset
- Extracted only columns containing mean and standard deviation measurements, along with subject, activity and training
- Replaced numeric activity codes with descriptive names using a lookup table
- Created a second dataset by calculating the mean of each variable, grouped by subject and activity