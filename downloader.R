directory <- "~/Documents/PROGRAMMING/git/PSX-R"
setwd(directory)

library(curl)
library(lubridate)

filesList <- list.files("./data/")

startDate <- as.Date("2018-01-01") ## R default date format
endDate <- as.Date("2018-09-01")

loopDate <- startDate
while(loopDate < endDate) {
    if (wday(loopDate) %in% c(2:6)) {
        currentDate <- format(loopDate, format="%Y%m%d")
        ext <- ".lis.Z"
        ext2 <- ".lis"
        if (!(file.exists(paste0("data/",currentDate,ext)) | file.exists(paste0("data/",currentDate,ext2)))) {
            url <- paste0("https://www.psx.com.pk/scripts/communicator.php?f=", currentDate, ext,"&l=Hd")
            
            download.file(url, file.path("error", paste0(currentDate,ext)), method="curl")
            message("downloaded", paste0(currentDate,ext))
            Sys.sleep(2)
        }
        
        }
    loopDate  <- loopDate + 1
    }

#list.files("./data/")
