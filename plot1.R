
# Devon Smith 
# 2015-04-09
# Exploratory Data Analysis
# Course Project 1
# Plot 1

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
png(file="plot1.png", width=480, height=480)

# Plot histogram
hist(hpc$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")

# Turn device off
dev.off()


