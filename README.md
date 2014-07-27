Coursera Course - Get and Clean Data - Course Project
=====================================================

# Tidy Data File

I was unable to upload the tidy data file on the Coursera website. I have
uploaded my tidy data file to GitHub. Here's the link to the tidy data file.

# Explanation of the analysis

- Refer to file run_analysis.R
- The data files must reside in the sub directory "UCI HAR Dataset"

1. The data files are read in and stored in data frames with labels data_*

2. The subject data, X data, Y data for the train and test cases are combined 
into one large table called "t"

3. The column names corresponding to the means and standard deviations in the newly create table are then determined and extracted. The sub measurements for the
X, Y, and X dimensions are removed from this to get only the overall measurements for mean and stnadard deviation.

4. Once these columns are extracted from the larger table, they are then recombined into a tidy data table. The Activity data frame is converted to character to allow for cleaner and appropriate ordering.

5. The resulting ordered data is then written to the data file called "tidy.csv"

