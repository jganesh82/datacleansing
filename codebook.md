This run_analysis R script will check if the zip file is present in your working directory. (If not, will download and unzip the file)

1. Read test data
subject_test : subject IDs for test
data_test : values of variables in test
activity_test : activity ID in test

2. Read train data
subject_train : subject IDs for train
data_train : values of variables in train
activity_train : activity ID in train

3. Read generic data
activity_labels : Description of activity IDs in activity_test and activity_train
features : description(label) of each variables in data_test and data_train

4. Merge data
dataset : bind of activity_train and activity_test

5. Extract only mean() and std()
remove the columns other than those with mean() and std() from dataset.
meanstd : a vector of only mean and std labels extracted from 2nd column of features
dataSet will only contain mean and std variables

6. Changing Column label of dataSet
Rename the names of the dataset by getting rid of "()" at the end.
cleanedNames : is a vector with names tidied up

7. Adding Subject and Activity to the dataSet
do exclusive merge of test data and train data of subject and activity. Bind the same with dataset. Now we have the final dataset will all the columns.

subject : bind of subject_train and subject_test
activity : bind of activity_train and activity_test

8. Rename ID to activity name
Group the activity column of dataSet as "activity_grp", then rename each levels with 2nd column of activity_levels. Finally apply the renamed "activity_grp" to dataSet's activity column.
activity_grp : factored activity column of dataSet

9. clean output data
Now in this final step dataset is melted to create clean data. Final output is saved as "clean_data.txt"

firstDataSet : melted dataSet
secondDataSet : cast firstDataSet which has means of each variables