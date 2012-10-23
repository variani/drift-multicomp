library(plyr)
library(reshape)
library(ggplot2)

### parameters
dir <- "data/Medidas_compuestos_y_tomates/TOMATES"

### list files
files <- list.files(dir) # just files, complete path is omitted

# filter files
files <- grep("^T", list.files(dir), value = TRUE) # files tasrting with "T"

# add back path to `files`
files <- file.path(dir, files)

### read files to a list
system.time(dat.list <- lapply(files, function(x) read.table(x, sep = '')))

dat.dims <- data.frame(nrow = laply(dat.list, nrow), ncol = laply(dat.list, ncol))

stopifnot(all(dat.dims$nrow == 630))
stopifnot(all(dat.dims$ncol == 16))

### copy data to a 3D array
nsamples <- length(dat.list)
npoints <- 630
nsensors <- 16
dat <- array(dim = c(nsamples, npoints, nsensors), 
  dimnames = list("1" = paste("sample", 1:nsamples, sep = ""),
    "2" = paste("t", 1:npoints, sep = ""),
    "3" = paste("S", 1:nsensors, sep = "")))
  
for(i in 1:nsamples) {
  for(s in 1:nsensors) {
    dat[i, , s] <- dat.list[[i]][, s]
  }
}

### info
info <- data.frame(file = files, stringsAsFactors = FALSE)
info <- mutate(info,
  dir = dirname(file),
  file = basename(file),
  label = factor(ifelse(substr(file, 1, 11) == "Tarbolverde", "Tarbol Verde", 
    ifelse(substr(file, 1, 12) == "Tarbolmaduro", "Tarbol Maduro", NA))),
  date = file.info(files)$mtime)

info <- info[with(info, order(date)), ]
info$index <- 1:nrow(info)

summary(info$label)

p1 <- qplot(index, date, data = info)
p1

### plot
df <- as.data.frame(dat[1, , ])
df$time <- 1:nrow(df)
mf <- melt(df, id.vars = "time")

p2 <- qplot(time, value, data = mf, color = variable, geom = "line")
p2

ind <- which(info$label == "Tarbol Verde")
df <- as.data.frame(t(dat[ind, , 1]))
matplot(df, t = 'l')

#df$date <- info[ind, "date"]
#mf <- melt(df, id.vars = "date")

#p3 <- qplot(date, value, data = mf, color = variable, geom = "line")
#p3

