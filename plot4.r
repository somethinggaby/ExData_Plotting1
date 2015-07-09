#set working directory 
setwd("C:/Users/matr06581/Desktop/Data Analysis")
#download
if (!file.exists("data.zip")) {
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile="data.zip")
  unzip("data.zip")
}
#clean data 
data = read.csv("household_power_consumption.txt",
                skip=66637,
                nrows = 2880,
                na.strings = "?",
                header = F,
                sep = ";") 
names(data) = names(read.csv("household_power_consumption.txt", nrows = 1, sep = ";"))
data$DateTime = as.POSIXct(paste(data$Date, data$Time, sept= " "),
                           format ="%d/%m/%Y %H:%M:%S")
data$Date = as.Date(data$Date, format = "%d/%m/%y")
data$Time = strptime(data$Time, format = "%H:%M:%S") 
#Set up 2 by 2 charts 
par(mfcol = c(2, 2))
#plot all 
plot(data$DateTime, data$Global_active_power, type="l", ylab = "Global Active Power", xlab = "")

plot(data$DateTime, data$Sub_metering_1, type="l", ylab = "Energy sub metering", xlab = "")
lines(data$DateTime, data$Sub_metering_2, type="l", ylab = "Energy sub metering", xlab = "", col = "red")
lines(data$DateTime, data$Sub_metering_3, type="l", ylab = "Energy sub metering", xlab = "", col = "blue")

legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", lty = 1)

plot(data$DateTime, data$Voltage, type="l", ylab = "Voltage", xlab = "datetime")

plot(data$DateTime, data$Global_reactive_power, type="l", ylab = "global_reactive_power", xlab = "datetime")

#save 
dev.copy(png, file = "plot4.png", width = 480, height = 480) 
dev.off() 
