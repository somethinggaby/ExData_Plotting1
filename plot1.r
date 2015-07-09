#Set working directery 
setwd("C:/Users/matr06581/Desktop/Data Analysis")
#download file
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
#plot
hist(data$Global_active_power,main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
#save 
dev.copy(png, file = "plot1.png", width = 480, height = 480) 
dev.off() 
