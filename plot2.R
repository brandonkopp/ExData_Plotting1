#EXPLORATORY DATA ANALYSIS
#COURSE PROJECT 1
#CREATE PLOT 2

#GETTING THE DATA
if (!file.exists("data")){
  dir.create("data")
}

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,destfile="./data/power.zip", method="curl")

dateDownloaded <- date()
dateDownloaded

#SUBSETTING AND FORMATTING THE DATA
power <- read.table(unz("./data/power.zip", "household_power_consumption.txt"), header=T,sep=";", stringsAsFactors = FALSE,na.strings = "?")
power <- power[power$Date == "1/2/2007" | power$Date == "2/2/2007",  ]
power$DateTime <- as.POSIXct(paste(power$Date, power$Time), format="%d/%m/%Y %H:%M:%S")
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
power$Time <- strptime(power$Time,"%H:%M:%S")

#PLOT 2
png("plot2.png")
plot(x = power$DateTime, y = power$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power (kilowatts)")
dev.off()