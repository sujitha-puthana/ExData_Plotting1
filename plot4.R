

# load dplyr package
library(dplyr) 

## Download and unzip data
file.name <- "./household_power_consumption.txt"
url       <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip.file  <- "./data.zip"

# Check if the data is downloaded and download when applicable

if (!file.exists("./household_power_consumption.txt")) {
  download.file(url, destfile = zip.file)
  unzip(zip.file)
  file.remove(zip.file)
}

#read data
data_full <- read.table("household_power_consumption.txt", header=TRUE, na.strings="?", sep=";")

## filter data from dates 2007-02-01 and 2007-02-02
data <- data_full[(data_full$Date=="1/2/2007" | data_full$Date=="2/2/2007" ), ]


# convert date and time to proper formats
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$timetemp <- paste(data$Date, data$Time)
data$Time <- strptime(data$timetemp, format = "%Y-%m-%d %H:%M:%S")

png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
with(data, {
  plot(x = data$Time, y = data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
  plot(x = data$Time, y = data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  plot(x = data$Time, y = data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(x = data$Time, y = data$Sub_metering_2, type = "l", col = "red")
  lines(x = data$Time, y = data$Sub_metering_3, type = "l", col = "blue")
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(x = data$Time, y = data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})
dev.off()