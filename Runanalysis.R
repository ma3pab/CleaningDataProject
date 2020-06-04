# Run Analysis Script for Getting and Cleaning Data Project
# Date: June 2020


### Load Relevant libraries ----------------------------------------------------

library(rstudioapi)
library(dplyr)

### 0. Load Initial Data --------------------------------------------------------

# Obtain the current directory to load in initial datasets
# RStudioApi package will need to be installed
directory_path <- dirname(rstudioapi::getActiveDocumentContext()$path)

# Use read.table to load in the test and train datasets (ignoring intertial signals data)
        # Data identifying the subject for each test in the x test dataset        
        subjecttestdata <- read.table(paste0(directory_path, "/UCI HAR Dataset/test/subject_test.txt"))

        # Data identifying the results of the tests in the test dataset        
        xtestdata <- read.table(paste0(directory_path, "/UCI HAR Dataset/test/X_test.txt"))
        
        # Data containing the test labels of the test dataset
        ytestdata <- read.table(paste0(directory_path, "/UCI HAR Dataset/test/Y_test.txt"))
 
        # Data identifying the subject for each test in the x train dataset             
        subjecttraindata <- read.table(paste0(directory_path, "/UCI HAR Dataset/train/subject_train.txt"))
        
        # Data identifying the results of the tests in the train dataset 
        xtraindata <- read.table(paste0(directory_path, "/UCI HAR Dataset/train/X_train.txt"))
        
        # Data containing the test labels of the train dataset
        ytraindata <-  read.table(paste0(directory_path, "/UCI HAR Dataset/train/Y_train.txt"))


### 1. Merge Test and Training Datasets to Create one dataset ---------------------
        
        # Merge Test Data into single data table first. This has been completed using the 
        # cbind function after confirmed the number of rows are the same in each dataframe
        
        
        # Combine the subject identifiers with the test labels and finally the test data        
        mergedtestdata <- cbind(subjecttestdata, ytestdata, xtestdata) 
        
        # Same operation for the training data - note cbind retains the order of rows when joining
        mergedtraindata <- cbind(subjecttraindata, ytraindata, xtraindata) 
        
        # Now combine the training and test data into a complete dataset by row binding the
        # datasets together (after confirming the column dimensions are the same)
        
        mergedactivitydata <- rbind(mergedtestdata, mergedtraindata)

### 2. Use Descriptive Variable Names ------------------------------------------

        # Read in variable names supplied in features.txt
        # These relate to the 561 features and represent the columns in the raw data
        featurelabels <- read.table(paste0(directory_path, "/UCI HAR Dataset/features.txt"))
        
        # Amend label names to be in a consistant format 
        # (ie lowecase letters, numbers and periods only)        
        featureslabelslist <- tolower(featurelabels$V2) 
        featureslabelslist <- gsub("\\(", "", featureslabelslist) 
        featureslabelslist <- gsub("\\)", "", featureslabelslist) 
        featureslabelslist <- gsub(",", ".", featureslabelslist)         
        featureslabelslist <- gsub("-", ".", featureslabelslist) 
        
        # Replace Column Names of master data with new variable names
        colnames(mergedactivitydata) <- append(c("subject.id", "activity"), featureslabelslist)
     
### 3. Use Descriptive Activity Names ------------------------------------------
        
        # Read in activity labels supplied in activity_labels.txt
        # These six activity names relate to the 6 activity id's in the datset
        activitylabels <- read.table(paste0(directory_path, "/UCI HAR Dataset/activity_labels.txt"))
        mergedactivitydata$activity <- activitylabels$V2[mergedactivitydata$activity]
        
        
### 4. Extract only Mean and Std Dev Columns ----------------------------------      
        # Filtered only column names with std or mean (all will be lowercase as the
        # variable names have been standardised
        columnnames <- colnames(mergedactivitydata)
        namestokeep <- columnnames %in% grep("mean|std|subject.id|activity", columnnames, value = TRUE)
        mergedactivitydata <- subset(mergedactivitydata, select = namestokeep)

        
### 5. Create a tidy dataset with averages for mean and std dev columns --------  
        
        # Create an average for each unique subject.id and activity in the dataset
        # A tidy dataset will have one row per observation and one variable per column
        # Tidy data will have descriptive names without special characters
        # Data will not contain missing values
        
        # Average for each mean and std deviation column per subject and activity
                tidyactivitydata <- mergedactivitydata %>%
                group_by( subject.id, activity) %>%
                summarise_all(mean)
        
        # This is a final dataset in tidy form - for more details please see the readme
        # file as to why this is considered tidy data
        
        # output the final tidy dataset as a text file
        write.table(tidyactivitydata, file = paste0(directory_path, "/tidyactivitydata.txt"))        
        
     
        
        
        
               