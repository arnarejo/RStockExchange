# set local working directory
directory <- "~/Documents/PROGRAMMING/git/PSX-R"
setwd(directory)

# load libraries
library(lubridate)

# load and merge files
temp <- list.files("./data/")

# Note: make sure no empty files in the folder (may develop code to remove empty files)
stockData <- do.call(rbind, lapply(temp, function(x) read.csv(paste0("./data/",x), sep="|", header=FALSE)))

# apply headers, and format data
stockData <- stockData[,1:9]

colNames <- c("Date", "Symbol", "SectorCode", "Name", "Open", "High", "Low", "Close", "Volume")
names(stockData) <- colNames

stockData$Date <- dmy(stockData$Date)

# filter selective stocks for visualization
stocks <- c("OGDC", "POL", "PPL")
columns <- c("Date", "Symbol", "Name", "Close", "Volume")
filteredData <- stockData[stockData$Symbol %in% stocks,columns]

# save final data locally
save(filteredData, file = "filteredData.RData")