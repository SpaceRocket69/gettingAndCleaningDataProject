library(dplyr)

# Define URL and destination
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile <- tempfile(fileext = ".zip")

# Download the zip file
download.file(url, destfile, mode = "wb")

# Create a directory called "data" in your working directory
unzip_dir <- file.path(getwd(), "data")
dir.create(unzip_dir, showWarnings = FALSE)

# Unzip into the "data" directory
unzip(destfile, exdir = unzip_dir)

# List all .txt files (recursively)
txt_files <- list.files(unzip_dir, pattern = "\\.txt$", full.names = TRUE, recursive = TRUE)

print(txt_files)

# Joining the measurements with labels, column names and subjects
# Training data
x_training <- read.table(txt_files[27], header = FALSE, stringsAsFactors = FALSE)
ncol(x_training); nrow(x_training)
y_labels_train <- read.table(txt_files[28], header = FALSE, stringsAsFactors = FALSE)
ncol(y_labels_train); nrow(y_labels_train)
column_names <- read.table(txt_files[2], header = FALSE, stringsAsFactors = FALSE)
ncol(column_names); nrow(column_names)
subjects_train <- read.table(txt_files[26], header = FALSE, stringsAsFactors = FALSE)
ncol(subjects_train); nrow(subjects_train)

colnames(x_training) <- column_names[,2]
x_training$labels <- y_labels_train[,1]
x_training$training <- 1
x_training$subject <- subjects_train[,1]

# Testing data
x_testing <- read.table(txt_files[15], header = FALSE, stringsAsFactors = FALSE)
ncol(x_testing); nrow(x_testing)
y_labels_test <- read.table(txt_files[16], header = FALSE, stringsAsFactors = FALSE)
ncol(y_labels_test); nrow(y_labels_test)
subjects_test <- read.table(txt_files[14], header = FALSE, stringsAsFactors = FALSE)
ncol(subjects_test); nrow(subjects_test)

colnames(x_testing) <- column_names[,2]
x_testing$labels <- y_labels_test[,1]
x_testing$training <- 0
x_testing$subject <- subjects_test[,1]

# Combine dataframes
full_df <- rbind(x_training, x_testing)

# Extract mean and std values
names(full_df)

df_subset <- full_df %>%
  select(
    contains("mean"),
    contains("std"),
    labels,
    training,
    subject
  )

# Exchange activity numbers by activity names
activity_names <- read.table(txt_files[1], header = FALSE, stringsAsFactors = FALSE)
colnames(activity_names) <- c("label", "activity")

df_subset <- df_subset %>%
  left_join(activity_names, by = c("labels" = "label")) %>%
  select(-labels)

# Create summary
summary <- df_subset %>%
              group_by(subject, activity) %>%
              summarise(across(everything(), mean), .groups = "drop")

View(summary)

# Save df_subset as a text file (tab-delimited)
write.table(df_subset, file = "observations.txt", row.names = FALSE, sep = "\t", quote = FALSE)

# Save summary as a text file (tab-delimited)
write.table(summary, file = "summary_data.txt", row.names = FALSE, sep = "\t", quote = FALSE)