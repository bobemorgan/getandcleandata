# Getting and Cleaning Data Project
#
# The code for this project does the following:
#
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names. 
# 5) Creates a second, independent tidy data set with the average of each variable 
#    for each activity and each subject. 
#
dataset_folder       <- paste0(getwd(),"/UCI HAR Dataset")
file_activity_labels <- paste0(dataset_folder,"/activity_labels.txt")
file_features        <- paste0(dataset_folder,"/features.txt")
test_folder          <- paste0(dataset_folder,"/test")
train_folder         <- paste0(dataset_folder,"/train")
file_subject_test    <- paste0(test_folder,"/subject_test.txt")
file_x_test          <- paste0(test_folder,"/X_test.txt")
file_y_test          <- paste0(test_folder,"/y_test.txt")
file_subject_train   <- paste0(train_folder,"/subject_train.txt")
file_x_train         <- paste0(train_folder,"/X_train.txt")
file_y_train         <- paste0(train_folder,"/y_train.txt")

data_activity_labels <- read.table( file_activity_labels, stringsAsFactors=FALSE )
data_features        <- read.table( file_features, stringsAsFactors=FALSE )
data_subject_test    <- read.table( file_subject_test )
data_x_test          <- read.table( file_x_test )
data_y_test          <- read.table( file_y_test )
data_subject_train   <- read.table( file_subject_train )
data_x_train         <- read.table( file_x_train )
data_y_train         <- read.table( file_y_train )

s <- rbind(data_subject_test,data_subject_train)
x <- rbind(data_x_test,data_x_train)
y <- rbind(data_y_test,data_y_train)

names(s) <- "Subject"
names(x) <- data_features[,2]
names(y) <- "Activity"

sub_activity <- function(num) {
    data_activity_labels[num,2] 
}

y$Activity <- mapply(sub_activity,y$Activity)

t <- cbind(s,y,x)

# extract the names of all the measuements (columns)

tnames <- names(t)

# get the mean of measurements and exclude the X,Y,Z measurements
# so that only the total mean of a measurement is used

colMeans <- tnames[grep('mean',tnames)]
colMeans <- colMeans[grep('-[X|Y|Z]$',colMeans,invert=TRUE)]
c1 <- c(colMeans)
tMeans <- t[,c1]
str(tMeans)

# get the standard deviation of measurements and exclude the X,Y,Z measurements
# so that only the total standard deviation of a measurement is used

colStdDev <- tnames[grep('std',tnames)]
colStdDev <- colStdDev[grep('-[X|Y|Z]$',colStdDev,invert=TRUE)]
c2 <- c(colStdDev)
tStdDev <- t[,c2]
str(tStdDev)

# create a new data frame that consists only of the means and 
# standard deviations of the measurements. Add in the Subject and
# Activity at the begining of the table

tidy <- cbind(Subject=t$Subject,Activity=t$Activity,tMeans,tStdDev)
tidy$Activity <- as.character(tidy$Activity)
tidyOrdered <- tidy[order(tidy$Subject,tidy$Activity),]

write.csv(tidyOrdered,file="tidy.csv",row.names=FALSE)
