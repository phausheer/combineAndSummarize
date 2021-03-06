############################################################################
### C:\Users\p622403\Documents\Work\Coursera\RProg
### Assign3.r
### 64 bit R 3.2.2
########################################################################################################################################################
############################################################################
### inspectFeatures
############################################################################
installComboSummaryPackages  <- function() {
  install.packages("gdata", dependencies = c("Depends","Suggests"))
}
############################################################################
### inspectFeatures
############################################################################
inspectFeatures  <- function() {
  strDirNa <- "\\\\wtors003\\isg-secure\\ISG Big Data\\R\\Source\\Coursera\\Data\\UCI HAR Dataset\\"
  strFileNa <- "features.txt"
  vFullLocalFileName <- c(strDirNa, strFileNa)
  strFullLocalFileName <- paste(vFullLocalFileName, collapse="")
  dfFeatures  <- read.table(strFullLocalFileName)
  print(class(dfFeatures))
  #   print(head(dfFeatures))
  print(names(dfFeatures))
  print(str(dfFeatures))
  ### Save as local Excel File
  #   strExcelFileNa <- "features.xls"
  #   vFullLocalExcelFileName <- c(strDirNa, strExcelFileNa)
  #   strFullLocalExcelFileName <- paste(vFullLocalExcelFileName, collapse="")
  #   SaveDataFrameAsExcel(dfFeatures, strFullLocalExcelFileName)
  vNames <- dfFeatures$V2
  print(vNames[1:3])
  vNew1 <- gsub("()", "",  vNames, fixed = TRUE)
  vNew2 <- gsub("^t", "time_",  vNew1)
  vNew3 <- gsub("^f", "frequency_",  vNew2)
  vNew4 <- gsub(",", "_",  vNew3)
  vNewNames <- gsub("-", "_",  vNew4)
  print(vNewNames[1:30])
}
getDataDir <- function() {
  ### Working on the LAN
  # strDirNa <- "\\\\wtors003\\isg-secure\\ISG Big Data\\R\\Source\\Coursera\\Data\\UCI HAR Dataset\\"
  strDirNa <-getwd()
  return(strDirNa)
}
getColumnNamesFromFeaturesFile <- function() {
  strDirNa <- getDataDir()
  strFileNa <- "features.txt"
  vFullLocalFileName <- c(strDirNa, strFileNa)
  strFullLocalFileName <- paste(vFullLocalFileName, collapse="")
  dfFeatures  <- read.table(strFullLocalFileName)
  #   print(class(dfFeatures))
  #   print(names(dfFeatures))
  #   print(str(dfFeatures))
  vNames <- dfFeatures$V2
  #   print(vNames[1:3])
  vNew1 <- gsub("()", "",  vNames, fixed = TRUE)
  vNew2 <- gsub("^t", "time_",  vNew1)
  vNew3 <- gsub("^f", "frequency_",  vNew2)
  vNew4 <- gsub(",", "_",  vNew3)
  vNew5 <- gsub("(", "_",  vNew4, fixed = TRUE)
  vNew6 <- gsub(")", "_",  vNew5, fixed = TRUE)
  vNewNames <- gsub("-", "_",  vNew6, fixed = TRUE)
  #   print(vNewNames[1:30])
  return(vNewNames)
}
############################################################################
### inspectData
############################################################################
inspectData <- function() {
  library(data.table)
  ### Clear previously loaded varialbes and functions
  #   strDirNa <- "\\\\wtors003\\isg-secure\\ISG Big Data\\R\\Source\\Coursera\\Data\\UCI HAR Dataset\\train\\"
  strDirNa <- "\\\\wtors003\\isg-secure\\ISG Big Data\\R\\Source\\Coursera\\Data\\UCI HAR Dataset\\test\\"
  #   strFileNa <- "subject_train.txt"
  strFileNa <- "subject_test.txt"
  #   strFileNa <- "X_train.txt"
  #   strFileNa <- "y_test.txt"
  vFullLocalFileName <- c(strDirNa, strFileNa)
  strFullLocalFileName <- paste(vFullLocalFileName, collapse="")
  #   dfWhat <- read.table(strFullLocalFileName)
  dtContents <- data.table(read.table(strFullLocalFileName))
  print(class(dtContents))
  print(tables())
  #   print(head(dfWhat))
  ### Save as local Excel File
  strExcelFileNa <- gsub("txt","xls",strFileNa)
  vFullLocalExcelFileName <- c(strDirNa, strExcelFileNa)
  strFullLocalExcelFileName <- paste(vFullLocalExcelFileName, collapse="")
  SaveDataFrameAsExcel(dtContents, strFullLocalExcelFileName)
}
############################################################################
### merge_Test_Train_Data
### rbind: http://stackoverflow.com/questions/15014339/rbind-with-new-columns-and-data-table
### merge : q()http://stackoverflow.com/questions/1299871/how-to-join-merge-data-frames-inner-outer-left-right
### ############################################################################
merge_Test_Train_Data <- function() {
  library(plyr)
  dtTest <- getTestDataSet()
  dtTrain <- getTrainDataSet()
  dtBoth <- rbind(dtTest, dtTrain)
  print("*** dtBoth ***")
  print(class(dtBoth))
  print(ncol(dtBoth))
  print(nrow(dtBoth))
  # print(names(dtBoth)[1:5])
  dtBothOrder <- arrange(dtBoth, subject, activity)
  strDirNa <- getDataDir()
  ### debug ###
#   strExcelFileNa <- "dtBothOrder.xls"
#   vFullLocalFileName <- c(strDirNa, strExcelFileNa)
#   strFullLocalFileName <- paste(vFullLocalFileName, collapse="")
#   SaveDataFrameAsExcel(dtBothOrder, strFullLocalFileName)
  
#   strCSVFileNa <- "dtBothOrder.csv"
#   vFullCSVFileName <- c(strDirNa, strCSVFileNa)
#   strFullCSVFileName <- paste(vFullCSVFileName, collapse="")
#   write.table(dtBothOrder, strFullCSVFileName, sep=",", row.names=FALSE, col.names = TRUE) 
#   
  dtMeanAndTidy <- dtBothOrder %>% group_by( subject, activity) %>% summarise_each(funs(mean))
  print("***  dtMeanAndTidy     ***")
  print(dim(dtMeanAndTidy))
  ### debug ###
#   strExcelFileNa <- "dtMeanAndTidy.xls"
#   vFullLocalExcelFileName <- c(strDirNa, strExcelFileNa)
#   strFullLocalFileName <- paste(vFullLocalExcelFileName, collapse="")
#   SaveDataFrameAsExcel(dtMeanAndTidy, strFullLocalFileName)
  
  strCSVFileNa <- "dtMeanAndTidy.csv"
  vFullCSVFileName <- c(strDirNa, strCSVFileNa)
  strFullCSVFileName <- paste(vFullCSVFileName, collapse="")
  write.table(dtMeanAndTidy, strFullCSVFileName, sep=",", row.names=FALSE, col.names = TRUE) 

  strTXTFileNa <- "dtMeanAndTidy.txt"
  write.table(dtMeanAndTidy, strTXTFileNa, sep=",", row.names=FALSE, col.names = TRUE) 
  
  print("*** dtBoth End  ***")  
}
###########################################################################
### grepTest
### http://stackoverflow.com/questions/7187442/how-to-filter-a-vector-of-strings-in-r-based-on-string-matching
### ############################################################################
grepTestDoesNotWork <- function() {
  ### string contains
#   vRaw <- c('cat', 'dog', 'cow', 'acat', 'adog', 'acow', 'adogcat', 'catb', 'bcow')
#   vOnlyPets <- grep(glob2rx("*cat*"), vRaw, value = TRUE)
#   print(vOnlyPets)
  
  strDirNa <- "\\\\wtors003\\isg-secure\\ISG Big Data\\R\\Source\\Coursera\\Data\\UCI HAR Dataset\\"
  strFileNa <- "features.txt"
  vFullLocalFileName <- c(strDirNa, strFileNa)
  strFullLocalFileName <- paste(vFullLocalFileName, collapse="")
  dfFeatures  <- read.table(strFullLocalFileName)
  print(class(dfFeatures))
  #   print(head(dfFeatures))
  print(names(dfFeatures))
  print(str(dfFeatures))
  vColumnNames <- as.vector(dfFeatures$V2)
  print(length(vColumnNames))
  vGoodColumns <- c(grep(glob2rx("*mean*"), vColumnNames, value = TRUE), grep(glob2rx("*std*"), vColumnNames, value = TRUE))
  print(length(vGoodColumns))
  print(vGoodColumns)
}
getAllColumnNameVector <- function() {
  strDirNa <- "\\\\wtors003\\isg-secure\\ISG Big Data\\R\\Source\\Coursera\\Data\\UCI HAR Dataset\\"
  strFileNa <- "features.txt"
  vFullLocalFileName <- c(strDirNa, strFileNa)
  strFullLocalFileName <- paste(vFullLocalFileName, collapse="")
  dfFeatures  <- read.table(strFullLocalFileName)
  # print(class(dfFeatures))
  # print(head(dfFeatures))
  # print(names(dfFeatures))
  # print(str(dfFeatures))
  vColumnNames <- as.vector(dfFeatures$V2)
  # print(length(vColumnNames))
  return(vColumnNames)
}
############################################################################
### getMeanStdColumnNames
### https://cran.r-project.org/web/packages/stringr/stringr.pdf
### Regex with OR for exact words
### https://www.icewarp.com/support/online_help/203030104.htm
### ############################################################################
getMeanStdColumnNames <- function(vColumnNames) {
  library(stringr)
  
  # vColumnNames <- getAllColumnNameVector()
  # print(vColumnNames)
  # vGoodColumns <- str_locate_all(vColumnNames, c("mean"))
  vMeanStdColumnNames <- str_subset(vColumnNames, "mean|std")
  
  ##############################################################
  ### test grep
  ##############################################################
#   print("*** grep test ***")
#   vMatch <- c("mean","std")
#   vMatches <- grep('mean|std', vAllColumnNames, value=TRUE)
#   print("*** vMatches ***")
#   print(class(vMatches))
#   print(length(vMatches))
#   print(vMatches)
  return(vMeanStdColumnNames)
}
### ############################################################################
### getTestDataSet
### ############################################################################
getTestDataSet <- function() {
  library(data.table)
  library(dplyr)
  # library(gdata)
  strDirNa <- paste(getDataDir(), "test\\", sep="")
#   strDirNa <- "\\\\wtors003\\isg-secure\\ISG Big Data\\R\\Source\\Coursera\\Data\\UCI HAR Dataset\\test\\"
  strFileNa <- "X_test.txt"
  vFullLocalFileName <- c(strDirNa, strFileNa)
  strFullLocalFileName <- paste(vFullLocalFileName, collapse="")
  #   dfWhat <- read.table(strFullLocalFileName)
  # dtContents <- data.table(read.table(strFullLocalFileName), colClasses = "numeric", nrows = 5)
  dtContents <- data.table(read.table(strFullLocalFileName) )
  print(class(dtContents))
  # print(tables())
  
#   vAllColumnNames <- getAllColumnNameVector()
  vAllColumnNames <- getColumnNamesFromFeaturesFile()
  # colnames(dtContents) <- vAllColumnNames
  setnames(dtContents, names(dtContents), vAllColumnNames)
  print("*** dtContents ***")
  print(class(dtContents))
  print(ncol(dtContents))
  print(nrow(dtContents))
  
  vMeanStdColumnNames <- getMeanStdColumnNames(vAllColumnNames)
  print("*** vMeanStdColumnNames ***")
  print(length(vMeanStdColumnNames))
  print(vMeanStdColumnNames[11:20])
  # dtGoodCols <- select(dtContents, vMeanStdColumnNames)
  # dtGoodCols <- select(dtContents,contains("mean")|contains("std"))
  # dtGoodCols <- select(dtContents,contains("mean"))
  
  ##x dtGoodCols <- dtContents[,vColPos]
  # vnGoodCols <- dtContents[,vMeanStdColumnNames]
  # dtGoodCols <- select(dtContents, c("tGravityAcc-std()-Y", "tGravityAcc-std()-Z", "tBodyAccJerk-mean()-X" ))
  # vnGoodCols <-dtContents[, "tGravityAcc-std()-Y"]
  vblnGoodCols <- dtContents[,colnames(dtContents) %in% vMeanStdColumnNames] 
  print("*** vblnGoodCols ***")
  print(class(vblnGoodCols))
  print(length(vblnGoodCols))
  print(vblnGoodCols[1:7])
  
  # dtGoodCols <- dtContents[,vnGoodCols]
   # dtGoodCols <- dtContents[, .("tGravityAcc-std()-Y", "tGravityAcc-std()-Z", "tBodyAccJerk-mean()-X" )]
  ######################################################################################################################
  ### Subsetting a data.table
  ### http://stackoverflow.com/questions/28094645/select-subset-of-columns-in-data-table-r
  ######################################################################################################################
  dtGoodCols <- dtContents[, .SD, .SDcols=vMeanStdColumnNames ]
  print("*** dtGoodCols ***")
  print(class(dtGoodCols))
  print(nrow(dtGoodCols))
  print(ncol(dtGoodCols))
  # print(dtGoodCols[1:3,])
  
#   vblnColPos <- as.vector(vAllColumnNames %in% vMeanStdColumnNames)
#   print("*** vblnColPos ***")
#   print(class(vblnColPos))
#   print(length(vblnColPos))
#   print(vblnColPos[1:7])
  
  #################################################################
  ### get Activity Column
  #################################################################
  strFileNa <- "y_test.txt"
  vFullLocalFileName <- c(strDirNa, strFileNa)
  strFullLocalFileName <- paste(vFullLocalFileName, collapse="")
  dtActivities <- data.table(read.table(strFullLocalFileName))
  # colnames(dtActivities) <- c("activity")
  # setnames(dtActivities, names(dtActivities), c("activity"))
  setnames(dtActivities, "V1", "activity")
  print("*** dtActivities ***")
  print(class(dtActivities))
  print(ncol(dtActivities))
  print(nrow(dtActivities))
  print(names(dtActivities))
  print("*** dtActivities End ***")
  
  ######################################################################################
  ### mapvalue ### change Alpha codes to Alpha Desc text
  ######################################################################################
  vNums <- c(1:6)
  vWords <- c("Walking","Walking_Upstairs","Walking_Downstairs","Sitting","Standing","Laying")
  vNew <- mapvalues(dtActivities$activity, from = vNums, to=vWords)
  dtActivities$activity <- vNew  
  # print(tables())
  
  #################################################################
  ### add Activity Column
  #################################################################
  dt80 <- cbind(activity=dtActivities$activity, dtGoodCols)
  # setnames(dt80, "V1", "activity")
  print("*** dt80 ***")
  print(class(dt80))
  print(ncol(dt80))
  print(nrow(dt80))
  # print(names(dt80))
  print("*** dt80 End ***")
  
  #################################################################
  ### get Subject Column
  #################################################################
  strSubjFileNa <- "subject_test.txt"
  vFullLocalFileName <- c(strDirNa, strSubjFileNa)
  strFullLocalFileName <- paste(vFullLocalFileName, collapse="")
  dtSubjects <- data.table(read.table(strFullLocalFileName))
  setnames(dtSubjects, names(dtSubjects), c("subject"))
  # setnames(dtActivities, "V1", "activity")
  print("*** dtSubjects ***")
  print(class(dtSubjects))
  print(ncol(dtSubjects))
  print(nrow(dtSubjects))
  
  #################################################################
  ### add subject Column
  #################################################################
  dt81 <- cbind(subject=dtSubjects$subject, dt80)
  # setnames(dt80, "V1", "subject")
  print("*** dt81 ***")
  print(class(dt81))
  print(ncol(dt81))
  print(nrow(dt81))
#   print(names(dt81))
  print("*** dt81 End ***")
  
  ### debug ###
#   strExcelFileNa <- "dt81.xls"
#   vFullLocalFileName <- c(strDirNa, strExcelFileNa)
#   strFullLocalFileName <- paste(vFullLocalFileName, collapse="")
#   SaveDataFrameAsExcel(dt81, strFullLocalFileName)
  
  print(" getMeanStdColumns - complete")
  return(dt81)
}
############################################################################
### fixedWidthFileIntoDataFrame
### fill = TRUE http://stackoverflow.com/questions/18161009/error-in-reading-in-data-set-in-r
############################################################################
fixedWidthFileIntoDataFrame  <- function() {
  con = url("http://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for")
  # htmlCode = readLines(con)
  vWidths <- c(12, 7,4, 9,4, 9,4, 9,4)
  vColNames <- c("Week","SST1","SSTA1","SST2","SSTA2","SST3","SSTA3","SST4","SSTA4")
  # dfFWF <- read.fwf(con,  widths = vWidths,  header = FALSE, skip=4, strip.white = FALSE, blank.lines.skip = TRUE, stringsAsFactors = FALSE)  
  dfFWF <- read.fwf(con,  widths = vWidths,  header = FALSE, skip=4, stringsAsFactors = FALSE, fill = TRUE)  
  # setnames(dfFWF, names(dfFWF), vColNames)
  colnames(dfFWF) <- vColNames
  print(class(dfFWF))
  print(paste(ncol(dfFWF), "columns"))
  print(paste(nrow(dfFWF), "rows"))
  
  print(sum(dfFWF$SST2))
}
### ############################################################################
### getTrainDataSet
### ############################################################################
getTrainDataSet <- function() {
  library(data.table)
  library(dplyr)
  # library(gdata)
  
#   strDirNa <- "\\\\wtors003\\isg-secure\\ISG Big Data\\R\\Source\\Coursera\\Data\\UCI HAR Dataset\\train\\"
  strDirNa <- paste(getDataDir(), "train\\", sep="")
  strFileNa <- "X_train.txt"
  vFullLocalFileName <- c(strDirNa, strFileNa)
  strFullLocalFileName <- paste(vFullLocalFileName, collapse="")
  dtContents <- data.table(read.table(strFullLocalFileName) )
  print(class(dtContents))
  
  #   vAllColumnNames <- getAllColumnNameVector()
  vAllColumnNames <- getColumnNamesFromFeaturesFile()
  # colnames(dtContents) <- vAllColumnNames
  setnames(dtContents, names(dtContents), vAllColumnNames)
  print("*** dtContents ***")
  print(class(dtContents))
  print(ncol(dtContents))
  print(nrow(dtContents))
  
  vMeanStdColumnNames <- getMeanStdColumnNames(vAllColumnNames)
  print("*** vMeanStdColumnNames ***")
  print(length(vMeanStdColumnNames))
  # print(vMeanStdColumnNames[11:20])

    ######################################################################################################################
  ### Subsetting a data.table
  ### http://stackoverflow.com/questions/28094645/select-subset-of-columns-in-data-table-r
  ######################################################################################################################
  dtGoodCols <- dtContents[, .SD, .SDcols=vMeanStdColumnNames ]
  print("*** dtGoodCols ***")
  print(class(dtGoodCols))
  print(nrow(dtGoodCols))
  print(ncol(dtGoodCols))
  
  #################################################################
  ### get Activity Column
  #################################################################
  strFileNa <- "y_train.txt"
  vFullLocalFileName <- c(strDirNa, strFileNa)
  strFullLocalFileName <- paste(vFullLocalFileName, collapse="")
  dtActivities <- data.table(read.table(strFullLocalFileName))
  # colnames(dtActivities) <- c("activity")
  setnames(dtActivities, names(dtActivities), c("activity"))
  print("*** dtActivities ***")
  print(class(dtActivities))
  print(ncol(dtActivities))
  print(nrow(dtActivities))
  # print(names(dtActivities))
  print("*** dtActivities End  ***")
  ######################################################################################
  ### mapvalue ### change Alpha codes to Alpha Desc text
  ######################################################################################
  vNums <- c(1:6)
  vWords <- c("Walking","Walking_Upstairs","Walking_Downstairs","Sitting","Standing","Laying")
  vNew <- mapvalues(dtActivities$activity, from = vNums, to=vWords)
  dtActivities$activity <- vNew  
  
  #################################################################
  ### add Activity Column
  #################################################################
  dt80 <- cbind(activity=dtActivities$activity, dtGoodCols)
  print("*** dt80 ***")
  print(class(dt80))
  print(ncol(dt80))
  print(nrow(dt80))
  print("*** dt80 End  ***")
  # print(names(dt80))
  
  #################################################################
  ### get Subject Column
  #################################################################
  strSubjFileNa <- "subject_train.txt"
  vFullLocalFileName <- c(strDirNa, strSubjFileNa)
  strFullLocalFileName <- paste(vFullLocalFileName, collapse="")
  dtSubjects <- data.table(read.table(strFullLocalFileName))
  setnames(dtSubjects, names(dtSubjects), c("subject"))
  # setnames(dtActivities, "V1", "subject")
  print("*** dtSubjects ***")
  print(class(dtSubjects))
  print(ncol(dtSubjects))
  print(nrow(dtSubjects))
  print("*** dtSubjects End  ***")
  
  #################################################################
  ### add subject Column
  #################################################################
  dt81 <- cbind(subject=dtSubjects$subject, dt80)
  print("*** dt81 ***")
  print(class(dt81))
  print(ncol(dt81))
  print(nrow(dt81))
  # print(names(dt81))
  print("*** dt81 End  ***")
  
  ### debug ###
#   strExcelFileNa <- "dt81.xls"
#   vFullLocalFileName <- c(strDirNa, strExcelFileNa)
#   strFullLocalFileName <- paste(vFullLocalFileName, collapse="")
#   SaveDataFrameAsExcel(dt81, strFullLocalFileName)
  
  print(" getMeanStdColumns - complete")
  return(dt81)
}
############################################################################################
### replaceValuesWithText
### 1st value becomes Rows, 2nd Values become columnNames, count() becomes table values
############################################################################################
replaceValuesWithText <- function() {
  library(plyr)
  # vSomeText <- rep(c("1","2","3","4","5","6"),2)
  vSomeText <- sample(1:6,60,replace=TRUE)
  print(vSomeText)
  # matrix(rep("1","2"), nrow = 1, ncol = 12)
  dfZeroes <- data.frame(matrix(vSomeText, nrow = 10, ncol = 6), stringsAsFactors=FALSE)
  print("*** dfZeroes ***")
  print(class(dfZeroes))
  print(str(dfZeroes))
  print(dfZeroes)
  print("*** dfZeroes End ***")
  
  dfZeroes$X4[dfZeroes$X4=="1"] <- "Walking"
  dfZeroes$X4[dfZeroes$X4=="2"] <- "Walking_Upstairs"
  dfZeroes$X4[dfZeroes$X4=="3"] <- "Walking_Downstairs"
  dfZeroes$X4[dfZeroes$X4=="4"] <- "Sitting"
  dfZeroes$X4[dfZeroes$X4=="5"] <- "Standing"
  dfZeroes$X4[dfZeroes$X4=="6"] <- "Laying"
  print("*** dfZeroes ***")
  print(class(dfZeroes))
  print(str(dfZeroes))
  print(dfZeroes)
  print("*** dfZeroes End ***")
  
  ######################################################################################
  ### mapvalue testing
  ######################################################################################
  vNums <- c(1:6)
  vWords <- c("Walking","Walking_Upstairs","Walking_Downstairs","Sitting","Standing","Laying")
  vNew <- mapvalues(dfZeroes$X3, from = vNums, to=vWords)
  print(vNums)
  print(vWords)
  print(vNew)
  dfZeroes$X3 <- vNew
  print(dfZeroes) 
}
### ############################################################################
### groupingTest
### ############################################################################
groupingTest <- function() {
  
  library(data.table)
  library(dplyr) 
  strDirNa <- paste(getDataDir(), "test\\", sep="")
  strBaseFileNa <- "dt81.xls"
  vFullLocalFileName <- c(strDirNa, strBaseFileNa)
  strFullLocalFileName <- paste(vFullLocalFileName, collapse="")
  #   strLogFileNa <- NULL
  #   dfExcel <- DataFrameFromExcelFile(strDirNa, strBaseFileNa, toString(strLogFileNa))
  dfExcel <- DataFrameFromExcelFile(strFullLocalFileName, 1)
  dtContents <- data.table(dfExcel)
  
  dtGrouped <- group_by(dtContents, subject, activity)
  print("***  dtGrouped     ***")
  print(dim(dtGrouped))
  #   print(summary(dtGrouped))
  #   table(dtGrouped$subject, dtGrouped$activity)
  print(class(dtGrouped))
  print(names(dtGrouped))
  print(dtGrouped)
#   dtSummarized <- summarize(dtGrouped, mean(col1X))
  dtSummarized <- summarise_each(funs(mean))
  print("***  dtSummarized     ***")
  print(class(dtSummarized))
  print(names(dtSummarized))
  print(dtSummarized)
  
  ### summarize
  ### http://stackoverflow.com/questions/21644848/summarizing-multiple-columns-with-dplyr
  
  dtWhatsThis <- dtContents %>% group_by( subject, activity) %>% summarise_each(funs(mean))
  print("***  dtWhatsThis     ***")
  print(dtWhatsThis)
  # crossTabTest <- xtabs(tBodyAcc.mean...Z ~ subject + activity, data=dtGrouped)
  # print(crossTabTest)
  #   crossTabTest <- xtabs(~ subject + activity, data=dtGrouped)
  #   print(crossTabTest)
  #   print(head(dtGrouped, n=7))
  
  #### summarize
  # summarize(dtGrouped, mtest = mean(col1X))
  ### ddply xxx Not working
  # ddply(dtContents,.(subject),numcolwise(mean,na.rm = TRUE))
  ### lapply
  ### http://stackoverflow.com/questions/16513827/r-summarizing-multiple-columns-with-data-table
  #  dtContents[, lapply(.SD, mean, na.rm=TRUE) , by=activity]
  
  
}
