## Download raw zipped data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "household_power_consumption.zip"
download.file(fileUrl, destfile=paste("data", destfile, sep="/"))

## Unzip the dataset
unzip(paste("data", destfile, sep="/"), exdir="data")
data_dir <- setdiff(dir("data"), destfile)

## Read and subset the txt dataset
dat <- read.csv("./data/household_power_consumption.txt", header=T, sep=';', na.strings="?", nrows=2075259)
dat$Date <- as.Date(dat$Date, format="%d/%m/%Y")
dat <- subset(dat, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Convert date/time to datetime class
datetime <- paste(dat$Date,dat$Time)
dat <- data.frame(Datetime=as.POSIXct(datetime), dat[-c(1:2)])
class(dat$Datetime)
file.remove(paste0(getwd(),'/data/',dir('data')))
rm(data_dir, destfile, fileUrl, datetime)

## Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(dat, {
  plot(Global_active_power~Datetime, type="l",
  ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l",
  ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l",
  ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
  legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l",
  ylab="Global Rective Power (kilowatts)",xlab="")
})

## Save to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
