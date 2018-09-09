filesList <- list.files("error/", pattern=".Z$")
for (file in filesList) {
    x <- paste0("error/",file)
    unzip(x, exdir = "data/")
    file.rename("data/closing.lis", paste("data/",gsub(".Z","",file)))

}