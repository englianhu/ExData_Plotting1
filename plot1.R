## Download raw zipped data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "household_power_consumption.zip"
download.file(fileUrl, destfile=paste("data", destfile, sep="/"))
unzip(paste("data", destfile, sep="/"), exdir="data")
data_dir <- setdiff(dir("data"), destfile)

## Read txt dataset
dat <- read.csv("./data/household_power_consumption.txt", header=T, sep=';')
dat$Date <- as.Date(dat$Date, format="%d/%m/%Y")

## Subsetting the data
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data)
## Converting dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)
## Plot 1
hist(data$Global_active_power, main="Global Active Power",
xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
## Saving to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
