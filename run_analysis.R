# The data linked to from the course website represent data collected from the 
# accelerometers from the Samsung Galaxy S smartphone.
# 
# You should create one R script called run_analysis.R that does the following. 
# 1.Merges the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names. 
# 5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

#set parameters
library(plyr)

#read activity labels
df_ActLbl <- read.table("./activity_labels.txt", sep = " ", header = FALSE)
colnames (df_ActLbl) <- c("ActID", "ActLabel")

#read features
df_Features <- read.table("./features.txt", sep = " ", header = FALSE)
colnames (df_Features) <- c("FtrID", "FtrLabel")

#read the test data
#read subject test
df_subj <- read.table("./test/subject_test.txt", sep = "", header = FALSE)
colnames(df_subj) <- c("VolID")

#read x test
df_xtest <- read.table("./test/X_test.txt", sep = "", header = FALSE)
##4.Appropriately labels the data set with descriptive variable names.
colnames(df_xtest) <- df_Features$FtrLabel

#read y test
##3.Uses descriptive activity names to name the activities in the data set
df_ytest <- read.table("./test/y_test.txt", sep = "", header = FALSE)
colnames(df_ytest) = c("ActID")
df_ytest$rownum = seq(1:length(df_ytest$ActID)) #merge distorts data. use this variable to reset
df_ytest = merge(df_ytest, df_ActLbl, by.x= "ActID", by.y = "ActID", all = FALSE)
df_ytest = arrange(df_ytest, rownum) #put it back the original order

#merge df to create the test data
df_test = cbind(df_subj, "Activity.Label"= df_ytest$ActLabel, df_xtest)

#cleanup
rm(df_subj, df_xtest, df_ytest)

#read the train data
#read subject test
df_subj <- read.table("./train/subject_train.txt", sep = "", header = FALSE)
colnames(df_subj) <- c("VolID")

#read x train
df_xtrain <- read.table("./train/X_train.txt", sep = "", header = FALSE)
##4.Appropriately labels the data set with descriptive variable names.
colnames(df_xtrain) <- df_Features$FtrLabel

#read y train
##3.Uses descriptive activity names to name the activities in the data set
df_ytrain <- read.table("./train/y_train.txt", sep = "", header = FALSE)
colnames(df_ytrain) = c("ActID")
df_ytrain$rownum = seq(1:length(df_ytrain$ActID)) #merge distorts data. use this variable to reset
df_ytrain = merge(df_ytrain, df_ActLbl, by.x= "ActID", by.y = "ActID", all = FALSE)
df_ytrain = arrange(df_ytrain, rownum) #put it back the original order

#merge df to create the train data
df_train = cbind(df_subj, "Activity.Label"= df_ytrain$ActLabel, df_xtrain)

#cleanup
rm(df_subj, df_xtrain, df_ytrain)

##1.Merges the training and the test sets to create one data set.
df_merge = rbind(df_test, df_train)

#extract columns that are mean and std only. Only names having  -mean() and -std()
colNames = colnames(df_merge)
col_Mean = grep("-mean()", colNames, ignore.case = FALSE) #all columns that are means
col_Std = grep("-std()", colNames, ignore.case = FALSE) #all columns that are std

##2.Extracts only the measurements on the mean and standard deviation for each measurement.
df_mergems = df_merge[,c(1,2, col_Mean, col_Std)]


df_mergems$Activity.Label <- factor(df_mergems$Activity.Label)

##5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject.  
df_tidy = ddply(df_mergems, .(VolID, Activity.Label), numcolwise(mean))
summary(df_tidy)

#create a txt file to upload
write.table(df_tidy, file = "tidydataset.txt", sep="\t")
