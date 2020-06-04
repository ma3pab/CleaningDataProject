
# Readme Document for the Coursera Cleaning Data End of Course Assessment


This readme file documents the process of taking raw human activity 
data and turn this into a final filtered dataset which meets the principles
of tidy data

## Required R Packages
In order to run the script the dplyr package will need to
be installed. They can be installed using the following code:

install.packages("dplyr")


## Folder Structure
The repository contains a folder with the raw data called "UCI HAR Dataset".
This is where the orignial raw data is sourced from in the R script.

The data folder contains text files with the activity labels, features information and 
raw trial data. Sub folders contain data for subjects who were included in the training 
cohort (70% of subjects) and those in the test cohort (30% of subjects).

More information on the data structure and descriptions can be found in the Readme file within the 
main data folder.

## Running R Script (Runanalysis.R)
There is a single R script which runs all analysis and is called Runanalysis.R
This is split into seven sections which should be run in order to create the
tidy dataset.

Loading Libraries
	This loads the required dplyr package needed to run the script
	
0. Loading the raw data	
	The raw human activity recognition data from smartphones is read into R using the read table
	function and stores the subject id's, raw data and activity id's in three different dataframes
	for both the training dataset and test dataset
	
	Note the intertial signals data has been ignored as it wasn't required for this project
	
1. Merge test and training datasets into a single dataset
	The raw data containing the subject labels, the activity labels for the test data are
	combined into a single table using the cbind command which retains the order of the data.
	
	This is repeated for the training dataset
	
	Finally after confirming the dimensions of the data these are aggregated into a single
	"mergedactivitydata" dataframe by row binding the data together
	
2. Create descriptive variable names
	The variable names used in the data are provided in the features.txt file in the data folder.
	
	This provides names for the 561 tests in the data. These are read in and used as variable names
	for the columns which contain the trial output data.
	
	The variable names as loaded contain upper case and lower case and also a range of special characters.
	Variable names have been amended to include only lowercase letters and periods for consistancy. Names
	are descriptive with more details found within the codebook
	
	These variable names are then combined with a column name for the subject identifier (subject.id) and the activity
	identifier (activity) and replace the existing names using the colnames function
	
3. Create descriptive Activity Names
	The existing data contains activity IDs from one to six which represent six types of activities
	undertaken by each subject
	
	To be more descriptive the activity IDs are replaced with their activity names in the dataset

4. Extract Mean and Standard Deviation Columns
	Only column names for variables which include either the mean of std deviation of a task has
	been included in the next stage of analysis.
	
	This has been deemed to include all those with either mean or standard deviation anywhere within the 
	variable name.
	
	The filtering creates a vector of TRUE FALSE identifiers as to whether mean or std is in the name
	and the uses this to subset the dataset. This approach was taken over using the dplyr select
	command which requires all column names to be unique (not the case with the dataset)
	
	Note the columns which contain the subject id and activity name were also retained in the table
	named mergedactivitydata
	
5. Create a tidy dataset containing the mean for each subject for each activity
	Calculating the Mean
		The mergedactivitydata set has multiple observations for each subject and activity
		A mean for each variable across each observatoin (leaving the subject and activity unique)
		was calculated using dplyr by grouping the data first and then summarising with the mean function second
		
		The final dataset was then output as a .txt file into the working directory in a wide format
		which meets the principles of a tidy dataset as shown below.
		
		This dataset can be read back into R using the read.table command using the filepath where the output
		dataset is stored.
		
		
Tidy Data
	The final tidy dataset meeting the following priciples of tidy data:
		
	Each variable measured is in one column - in this case each variable relates to a different
		measurement types from the activity trackers which are stored in independent columns
				
	Each different observation is in a different row - each row of the dataset contains a unique 
			average for each subject for each activity and so fulfils this requirement
		
	One table for each kind of variable - the output dataset relates only to activity measurements
		from a single trial and have been normalised (therefore have the same units, and would be 
		be considered of the same type) and so are stored in the same table
		
	Include decriptive variable names - the names in the dataset show the type of activity and 
		are in a consistant readable format (lowercase with only periods and no special characters)
		
	No missing values - the data doesnt contain NA or missing values
		
		
	Note: whether tidy data is in a wide or long format can depend on the problem being posed. 
	(ref: Hadley Wickhams  article on Tidy Data https://vita.had.co.nz/papers/tidy-data.pdf). 
	In this case a wide dataset where the subject / activity pairs are considered independent variables
	a wide dataset is considered to be tidy
		
	
## Codebook
A complete desciption of the tidy dataset components can be found in the associated codebook	
		

	
	
	
	