library(dplyr)
headers <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")
xTestData <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
column_names <- headers[, 2]
colnames(xTestData) <- column_names

yTestData <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt",
                        col.names = "V1")

xTrainData <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
column_names <- headers[, 2]
colnames(xTrainData) <- column_names

yTrainData <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", 
                         col.names = "V1")

subjectTrain <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt",
                           col.names = "subject")

subjectTest <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt",
                          col.names = "subject")

testset <- xTestData
testset$V1 <- yTestData
testset$subject <- subjectTest

trainset <- xTrainData
trainset$V1 <- yTrainData
trainset$subject <- subjectTrain

main_df <- rbind(testset, trainset)
selected_cols <- main_df[, grep("mean\\(\\)|std\\(\\)|^V1$|^subject$", colnames(main_df))]

activities <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
selected_cols$V1 <- as.integer(selected_cols$V1[[1]])
selected_cols$subject <- as.integer(selected_cols$subject[[1]])
merged_df <- full_join(selected_cols, activities, by = "V1")

step3 <- subset(merged_df, select = -V1) %>% rename(activity = V2)
step4 <- step3

new_names <- gsub("-|\\(\\)-", ".", names(step4))
names(step4) <- new_names
new_names2 <- gsub("\\(\\)", "", names(step4))
names(step4) <- new_names2

step5 <- aggregate(. ~ activity + subject, data = step4, FUN = mean)
step5

tidy_dataset <- write.table(step5, row.names = FALSE)
file_path <- "tidy_dataset.txt"

# Use write.table() to create the text file
write.table(step5, file = file_path, row.names = FALSE)