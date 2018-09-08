# directory <- "~/Documents/PROGRAMMING/git/PSX-R"
library(curl)
library(lubridate)
setwd(directory)

startDate <- as.Date("2017-01-01") ## R default date format
endDate <- as.Date("2017-12-31")

loopDate <- startDate
while(loopDate < endDate) {
    if (wday(loopDate) %in% c(2:6)) {
        currentDate <- format(loopDate, format="%Y%m%d")
        ext <- ".lis.Z"
        url <- paste0("https://www.psx.com.pk/scripts/communicator.php?f=", currentDate, ext,"&l=Hd")
        
        download.file(url, file.path("data", paste0(currentDate,ext)), method="curl")
        Sys.sleep(2)
        
        }
    loopDate  <- loopDate + 1
    }

#list.files("./data/")
