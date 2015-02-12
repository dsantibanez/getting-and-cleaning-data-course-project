README Getting and Cleaning Data Course Project
Version 1.0

==================================================================
D.S.G. Script run_Analysis.R explanation
==================================================================


The first thing made was to study the README.txt document and other documents of the pack, understand the different files, read about what it is required on the Coursera website (Thanks David Hood) and finally carry out with the ideas suggested there.

As far as I understand, this codebook is about explaining everything I did in order to carry out with the 5 points of the exercise, not about explaining the raw data.

First thing I did was to read into R the every single file I thought would be useful to start working with them. So, I created the following data frames: 
- x_test,
- y_test,
- subject_test,
- x_train,
- y_train,
- activity_labels,
- features,
using the "read.table" command. There is not much to say about it, because the name of the variable correspond to the name of the files given by Coursera.

After that, I checked the dimension of every single dataset in order to find out the way they match, and when everything was clear, I created one unique dataset adding the information all together, so I created the following data frames. Everything was a matter of adding new columns with the values of the data frame added taking into account the dimension of every data frame added in order them to match:
- y_x_train: get together the training set with the training labels. Dim 7352  562 
- y_x_test: get together the test set with the test labels. Dim 2947  562
- subject_y_x_train: get together y_x_train with the subjects who did the train. Dim 7352  563
- subject_y_x_test: get together y_x_test with the subjects who did the test. Dim 2947  563

Then, I renamed the columns "subject" and "activity" of the data frames "subject_y_x_train" and "subject_y_x_test" with this exactly names in order to be more understandable. That didn't create new data frames.

After that step, I created a new data frame, "table_train_test", adding together all the rows from  "subject_y_x_train" and "subject_y_x_test" data frames. 
"table_train_test" has this dimensions: 10299   563. First column is "subject", second is "activity" and the rest are the values of the train and test.

After that, I created a new subset of data called "table_mean_std", which is a subset of "table_train_test", and contains only the columns with information about mean and standard deviation, as requested. For that, I checked the "feature" dataset, looking for values with the characters mean or std values in its second column (V2), remembered the value of the first column associate to the second column V2, looking for this value in the column names of my "table_mean_std data frame", example V53 in my data frame, the number I look for is 53, and create the "table_mean_std" data frame only with these columns. 

Nest step was to change the type of the "activity" column, from factor to character, and transform its numerical values into human readable values with the help of the activity_label.txt file. For that I used a loop FOR.

At this point, the column names of my data frame "table_mean_std" were: subject, activity, V1...V561 (but not all values, remember the last point). Now was the time tu rename this "Vx" column values into something more human understandable. For that I created a loop FOR where I was looking for the number after each V column and find a match within the features data frame, looking for the character value associated to this number, and I renamed the data frame. The data frame name kept being the same, just with some modifications.

The final point was to create a new data frame named  "table_mean_std_grouped", which contains the information of "table_mean_std" but grouped for subject and activity. For that, I transformed the data frame into data table, and then used a lapply function to group  by subject and activity and calculating the mean values of the rest of the variables/ columns. (.SD) did that. 

For the record, "table_mean_std_grouped" is going to be called tidy_dataset.txt in the deliverable group of files that Coursera requests. 
