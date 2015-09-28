#merge_Test_Train_Data()#

##1) Read the Test file into a data.table##

> keep only the columns with MEAN or STD in their name
 <br>this leaves a 79 column data.table
 <br>combine the data with  activities
 <br>rename the activties to be text
 <br>this creates an 80 column data.table
 <br>combine the with subjects
 <br>this creates an 81 column data.table, with 2947 rows

##2) Read the Training file into a data.table##

> keep only the columns with MEAN or STD in their name
 <br>this leaves a 79 column data.table
 <br>combine the data with  activities
 <br>rename the activties to be text
 <br>this creates an 80 column data.table
 <br>combine the with subjects
 <br>this creates an 81 column data.table, with 7352 rows

##3) Combine dtTest and dtTrain into dtBoth##
<br>this creates an 81 column data.table, with 10,299 rows

##4) I use group_by and summarize_each to create a 2nd tidy dataset## 
<br>that has the mean of each column in dtBoth
<br>I use the variable name dtMeanAndTidy

##5) I use write.table## 
<br>to create text file from dtMeanAndTidy
