# Getting_and_Cleaning_Data_Project
April 25 2015
By Vishal Prasad

Project 1 from the Getting and Cleaning Data course

I start off with saving all the required files in a central location and use it as my working directory. Then I read the text files from the test and train subdirectories, i.e. subject, X, and y. I update the variable names for the subject and y data initially because they're easier and quicker to deal with. To get the variable names for the X test and train data, I first read the features text file then apply the variable names from that file to the X test and train data. Once I've done that I remove any variables that don't have "mean()" or "std()" in the name.

Now I have all my data with common variable names I begin to clip the test and train data together using cbind and then I merge them with rbind. I wanted to keep it simple in terms of merging the datasets.

All the test and train data is in one data frame and contains 10,299 observations and 68 variables. From this point I need to update the activity values to their respective named values, i.e. 1 = WALKING, 2 = WALKING_UPSTAIRS, etc. I do this by using the within command in R.

I proceed to defining my independent tidy dataset. I narrowed my dataset down to only five variables as follows:
subject_id, activity, tBodyAcc-mean()-X, tBodyAcc-mean()-Y, tBodyAcc-mean()-Z

After defining my tidy dataset I renamed the variables for the means to something more meaningful, i.e. tBodyAcc-mean()-X became mean_body_acceleration_X. I then calculate the mean of each variable by subject_id and activity and this was achieved quite nicely with the sqldf package in R.

The last step is to write the data to a text file. I have named mine "tidy_data.txt". At the bottom of my script I've also included a couple of lines of commented code to show how the text file can be read back into R using read.table.

I chose to have a narrow set of data because like I mentioned previously I wanted to keep things simple and show that I'm able to apply the principles of cleaning the data.
