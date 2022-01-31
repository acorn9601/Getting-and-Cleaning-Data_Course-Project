# Getting-and-Cleaning-Data_Course-Project

**Part 1**: Merging training & test datasets into one

 * First, we downloaded and unzipped the files into the given directory
 * Then, we explored the names of the files within the dataset and loaded the subject, X, Y tables as subject, feature, activity.
 * Train and test datasets for each attribute was merged using row bind
 * Three datasets subject, feature, activity were mered using column bind
 * Column names were replaced with features.txt file 
 

**Part 2**: Extracting only measurement of mean and standard dev

 * First we found the indices of the feature names data that contained mean/std 
 * Second we subsetted the data with the column indices along with indices for subject, activity 
 
 
**Part 3**: Uses descriptive activity names

 * Read in the activity labels file 
 * Second we match activity names to activity column of the dataset - treating the values in the activity column as indices for the activity labels. 
 
 
**Part 4**: Appropriately label the dataset with descriptive variable names

 * Utilized gsub to filter to: 1) remove parenthese, 2) translate t, f to time and frequency 
 * Transformed to lower case
 * Transforedm - to _
 

**Part 5**: Creating the Tidy Data

 * Aggregated using the dplyr tool by activity and subject 