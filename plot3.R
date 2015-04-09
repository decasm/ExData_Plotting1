
# Devon Smith 
# 2015-04-09
# Exploratory Data Analysis
# Course Project 1
# Plot 3

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
png(file="plot3.png", width=480, height=480)

# Plot graph
plot(hpc$DT, hpc$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(hpc$DT, hpc$Sub_metering_1, col="black")
lines(hpc$DT, hpc$Sub_metering_2, col="red")
lines(hpc$DT, hpc$Sub_metering_3, col="blue")
legend("topright", lty=1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"))

# Turn device off
dev.off()

