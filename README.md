# getting-and-cleaning-data
This is part of an assignment for Johns Hopkins Universitys data science MOOC

1. I read in all the necessary files using data.table into different data.frames. At the same time I also create column names because I thought it was better to do it straight away.

2. Then I create the full "testset" and "trainset" by adding all columns to the same df.

3. After that I rowbind the rows from both dfs into the df called "main_df"

4. I save the needed columns that contains "mean()", "std()", "V1" (which is the activities), and "subject" into a df which I call "selected_cols"

5. I read in the activity names df and merge (join) it with selected_cols. And after that I remove the numerical representation of activities and only keep the verbal representation in a column that I call "activity

6. I tidy up the column names a bit more to follow the rule of only having letters, numbers and periods in the column names

7. Finally i create a new table consisting of the means of all variables for each specific combination of subject and activity and then save it to a txt file.

Enjoy! It said this assignment was going to take approximately 1 hour, it took me more like 6.
