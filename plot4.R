
# Devon Smith 
# 2015-04-09
# Exploratory Data Analysis
# Course Project 1
# Plot 4


# sqldf is used to select just the rows of interest from the input file
if ( ! "sqldf" %in% installed.packages() ) install.packages("sqldf")
library(sqldf)

# http://stackoverflow.com/questions/6592219/read-csv-from-specific-row/6596549#6596549
# Use sql to read in just the rows I want
hpc <- read.csv2.sql("household_power_consumption.txt", na.strings=c("?"), sql = 'select * from file where Date == "1/2/2007" or Date == "2/2/2007"') 

# http://stackoverflow.com/questions/11609252/r-tick-data-merging-date-and-time-into-a-single-object
# merge the separate Date and Time columns into one
hpc$DT <- as.POSIXct(paste(hpc$Date, hpc$Time), format="%d/%m/%Y %H:%M:%S")

# Create the png device
png(file="plot4.png", width=480, height=480)

# Set 2 x 2 grid, fill rows first
par(mfrow=c(2,2))

# Sub plot 1
plot(hpc$DT, hpc$Global_active_power, xlab="", ylab="Global Active Power", type="n")
lines(hpc$DT, hpc$Global_active_power)

# Sub plot 2
plot(hpc$DT, hpc$Voltage, xlab="datetime", ylab="Voltage", type="n")
lines(hpc$DT, hpc$Voltage)

# Sub plot 3
plot(hpc$DT, hpc$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(hpc$DT, hpc$Sub_metering_1, col="black")
lines(hpc$DT, hpc$Sub_metering_2, col="red")
lines(hpc$DT, hpc$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"), bty="n")

# Sub plot 4
plot(hpc$DT, hpc$Global_reactive_power, type="n", xlab="datetime", ylab="Global_reactive_power")
lines(hpc$DT, hpc$Global_reactive_power)

# Turn device off
dev.off()

