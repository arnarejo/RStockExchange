# set local working directory
directory <- "~/Documents/PROGRAMMING/git/PSX-R"
setwd(directory)

# load libraries
library(lubridate)

# load and merge files
temp <- list.files("./data/")

# Note: make sure no empty files in the folder (may develop code to remove empty files)

stockData <- do.call(rbind, lapply(temp, function(x) {
    pathName <- paste0("./data/",x)
    read.csv(pathName, sep="|", header=FALSE)
    }))

# apply headers, and format data
stockData <- stockData[,1:9]

colNames <- c("Date", "Symbol", "SectorCode", "Name", "Open", "High", "Low", "Close", "Volume")
names(stockData) <- colNames

stockData$Date <- dmy(stockData$Date)

# filter selective stocks for visualization
stocks <- c("ABL", "BAFL", "BAHL", "HBL", "MEBL", "NBP", "UBL", "NML", "NCL", "JDWS", "LUCK", "DGKC", "KOHC", "ISL", "INIL", "MLCF", "NRL", "ATRL", "HUBC", "KAPCO", "NPL", "NCPL", "KEL", "APL", "PSO", "ASL", "ASTL", "HCAR", "INDU", "AGIL", "THALL", "PAEL", "PTCL", "EFERT", "ENGRO", "FFC", "FFBL", "EPCL", "ICI", "CEPB", "MFL", "NATF", "NESTLE", "TGL", "TRIPF", "OGDC", "POL", "PPL", "MARI")

columns <- c("Date", "Symbol", "Name", "Close", "Volume")
filteredData <- stockData[stockData$Symbol %in% stocks,columns]

# save final data locally
save(filteredData, file = "filteredData.RData")