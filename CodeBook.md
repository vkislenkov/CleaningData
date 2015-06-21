# CodeBook describes the variables, the data, and any transformations or work that were performed to clean up the data.


## Dataset & variables
Please check the original dataset description in the dataset https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip (README file)

Variables include: activity (textual description) and subject id of person performing experiments. For every such pair there are computed averages of mean and std variables from the original dataset.

## Transformations 

Go into dataset directory

Read features file to obtain list of fields

Convert frame with field names into list

Identify all columns to keep in narrowed data set(mean and std)

Remove all () from column names in original set

Remove all () from column names in the narrowed data set

Convert all column names to use . instead of - to account for implicit R conversion

Read activity data labels

Go to Test directory

Load Test data, attach descriptive column names

Load Test labels, attach column name

Load Test Subjects

Go to Train directory

Load Train data, attach descriptive column names

Load Train labels, attach column name

Load Train Subjects

Concatenate Test and Train data

Concatenate Test and Train labels

Concatenate Test and Train subjects


Extract only std & mean measurements


Attach activity labels

Attach subject ids

Merge dataset with description activity names

Remove activityid column as unneeded

Summarize data to get mean across all subjects/all activities

Return to the original working directory

Write the output file
