## Part 1: Merging training & test datasets into one ##

# Downloading and unzipping the dataset

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./Week3_Project/Dataset.zip",method="curl")

unzip(zipfile="./Week3_Project/Dataset.zip",exdir="./Week3_Project")

# View the unzipped files 

path_rf <- file.path("./Week3_Project" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)
files

# Load the train data

train_activity <- read.table(file.path(path_rf, "train", "y_train.txt"))

train_subject <- read.table(file.path(path_rf, "train", "subject_train.txt"))

train_feature <- read.table(file.path(path_rf, "train", "x_train.txt"))

# Load the test data

test_activity <- read.table(file.path(path_rf, "test", "y_test.txt"))

test_subject <- read.table(file.path(path_rf, "test", "subject_test.txt"))

test_feature <- read.table(file.path(path_rf, "test", "x_test.txt"))


# Combine train & test data for each part of the dataset

subject <- rbind(train_subject, test_subject)
activity <- rbind(train_activity, test_activity)
feature <- rbind(train_feature, test_feature)

# Combine three dataframes to one data set 

dataset <- cbind(feature, subject, activity)

# Add column names from the 
feature.names <- read.table(file.path(path_rf, "features.txt"))
colnames(dataset)[1:561] <- feature.names$V2
colnames(dataset)[562] <- "subject"
colnames(dataset)[563] <- "activity"


## Part 2: Extracting only measurement of mean and standard dev##

# Subset feature names data that contain mean/std 
mean_std <- grep("mean\\(\\)|std\\(\\)", feature.names$V2)

# Filter for these columns in dataset
subset <- dataset[, c(mean_std, 562, 563)]
str(subset)

## Part 3: Uses descriptive activity names ##

# Read in the activity labels file 
activity.names <- read.table(file.path(path_rf, "activity_labels.txt"))

# Match activity names to indices
activity.names <- as.character(activity.names[,2])
subset$activity <- activity.names[subset$activity]

## Part 4: Approrpriately label the dataset with descriptive variable names ##

# Remove () at the end of each colum name
new.name <- names(subset)
new.name <- gsub("[()][)]", "", new.name)

# Translate t to time, f to frequency
new.name <- gsub("^t", "time_", new.name)
new.name <- gsub("^f", "frequency_", new.name)

# Unify "-" to underscore "_"
new.name <- gsub("*-", "_", new.name)

# Unify to lowercase
new.name <- tolower(new.name)

# Apply to original dataset
names(subset) <- new.name

## Part 5: Creating a tidy dataset of everages ##
summary <- aggregate(subset[,1:66], by = list(activity = subset$activity, subject = subset$subject),FUN = mean)
write.table(summary, file = "tidy_data.txt", row.name=FALSE)
