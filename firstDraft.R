############################################################################
### Desktop Machine
### C:\Users\p622403\Documents\Work\GitRepos\combineAndSummarize
### firstDraft.R
### 64 bit R 3.2
########################################################################################################################################################
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
  strExcelFileNa <- "features.xls"
  vFullLocalExcelFileName <- c(strDirNa, strExcelFileNa)
  strFullLocalExcelFileName <- paste(vFullLocalExcelFileName, collapse="")
  SaveDataFrameAsExcel(dfFeatures, strFullLocalExcelFileName)
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
### merge_Test_Train_y_data
### rbind: http://stackoverflow.com/questions/15014339/rbind-with-new-columns-and-data-table
### merge : q()http://stackoverflow.com/questions/1299871/how-to-join-merge-data-frames-inner-outer-left-right
### ############################################################################
merge_Test_Train_y_data <- function() {
  
}
############################################################################
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
  print(class(dfFeatures))
  #   print(head(dfFeatures))
  print(names(dfFeatures))
  print(str(dfFeatures))
  vColumnNames <- as.vector(dfFeatures$V2)
  print(length(vColumnNames))
  return(vColumnNames)
}
############################################################################
### getMeanStdColumnNames
### https://cran.r-project.org/web/packages/stringr/stringr.pdf
### Regex with OR for exact words
### https://www.icewarp.com/support/online_help/203030104.htm
### ############################################################################
getMeanStdColumnNames <- function() {
  library(stringr)
  
  vColumnNames <- getAllColumnNameVector()
  # print(vColumnNames)
  # vGoodColumns <- str_locate_all(vColumnNames, c("mean"))
  vMeanStdColumnNames <- str_subset(vColumnNames, "mean|std")
  
#   print(class(vMeanStdColumnNames))
#   print(length(vMeanStdColumnNames))
#   print(vMeanStdColumnNames)
  return(vMeanStdColumnNames)
}
### ############################################################################
### 
### ############################################################################
getMeanStdColumns <- function() {
  library(data.table)
  library(dplyr)
  
  strDirNa <- "\\\\wtors003\\isg-secure\\ISG Big Data\\R\\Source\\Coursera\\Data\\UCI HAR Dataset\\test\\"
  strFileNa <- "X_test.txt"
  vFullLocalFileName <- c(strDirNa, strFileNa)
  strFullLocalFileName <- paste(vFullLocalFileName, collapse="")
  #   dfWhat <- read.table(strFullLocalFileName)
  dtContents <- data.table(read.table(strFullLocalFileName))
  print(class(dtContents))
  print(tables())
  
  vAllColumnNames <- getAllColumnNameVector()
  # colnames(dtContents) <- vAllColumnNames
  setnames(dtContents, names(dtContents), vAllColumnNames)
  print(ncol(dtContents))
  
  # vMeanStdColumnNames <- getMeanStdColumnNames()
  # print(length(vMeanStdColumnNames))
  # dtGoodCols <- select(dtContents, vMeanStdColumnNames)
  dtGoodCols <- select(dtContents,contains("mean"))
  print(ncol(dtGoodCols))
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