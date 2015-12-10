#EXPLORATORY DATA ANALYSIS
#COURSE PROJECT 1
#CREATE PLOT 4

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

#Plot 4
png("plot4.png")
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(power, {
  plot(x = DateTime, y = Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  plot(x = DateTime, y = Voltage, type="l", xlab="datetime", ylab="Voltage")
  plot(x = power$DateTime, y = power$Global_active_power, type="n", xlab="", 
       ylab="Energy sub-metering", ylim = c(0,38))
  lines(x = power$DateTime, y = power$Sub_metering_1, col="black")
  lines(x = power$DateTime, y = power$Sub_metering_2, col="red")
  lines(x = power$DateTime, y = power$Sub_metering_3, col="blue")
  legend("topright",lty="solid", col = c("black","red","blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
  plot(x = DateTime, y = Global_reactive_power, type="l", xlab="datetime", ylab="Global Reactive Power")
})
dev.off()