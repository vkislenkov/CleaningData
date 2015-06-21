## Script to tidy up the accelerometers data
library(stringr)

## Load & Merge training & test data into one data set; also load activity labels
setwd("UCI\ HAR\ Dataset")
# Read features file to obtain list of fields
features <- read.table("./features.txt",sep=" ", header=FALSE)
# Convert frame with field names into list
feat <- features[,2]
# Identify all columns to keep in narrowed data set(mean and std)
columns <- feat[grepl("mean\\(",feat)|grepl("std\\(",feat)]
# Remove all () from column names in original set
feat <- str_replace(feat,"\\(\\)", "")
# Remove all () from column names in the narrowed data set
columns <- str_replace(columns,"\\(\\)", "")
# Convert all column names to use . instead of - to account for implicit R conversion
columns <- str_replace(columns,"-",".")
columns <- str_replace(columns,"-",".")

# Read activity data labels
aclabels<-read.table("./activity_labels.txt",col.names=c("id","activity"),header=FALSE)
# Go to Test directory
setwd("test")
# Load Test data, attach descriptive column names
testdata <- read.table("./X_test.txt",header=FALSE,col.names=feat)
# Load Test labels, attach column name
testlabels<-read.table("./y_test.txt", header=FALSE,col.names=c("activityid"))
# Load Test Subjects
testsubj<-read.table("./subject_test.txt",header=FALSE,col.names=c("subjectid"))
# Go to Train directory
setwd("../train")
# Load Train data, attach descriptive column names
traindata <- read.table("./X_train.txt",header=FALSE,col.names=feat)
# Load Train labels, attach column name
trainlabels<-read.table("./y_train.txt", header=FALSE,col.names=c("activityid"))
# Load Train Subjects
trainsubj<-read.table("./subject_train.txt",header=FALSE,col.names=c("subjectid"))

# Concatenate Test and Train data
data <- rbind (testdata,traindata)
# Concatenate Test and Train labels
labels <- rbind(testlabels,trainlabels)
# Concatenate Test and Train subjects
subj <- rbind(testsubj,trainsubj)

# Extract only std & mean measurements
ssdata <- data[,columns]

# Attach activity labels
jointlab<-cbind(ssdata,labels)
# Attach subject ids
jointsubj<-cbind(jointlab,subj)
# Merge dataset with description activity names
merged <- merge(jointsubj,aclabels,by.x="activityid",by.y="id",all=TRUE)
# Remove activityid column as unneeded
merged$activityid <- NULL

# Summarize data to get mean across all subjects/all activities
res<-ddply(merged,.(subjectid,activity),colwise(mean, columns))
# Return to the original working directory
setwd("../..")
# Write the output file
write.table(res,file="result.txt",row.name=FALSE)