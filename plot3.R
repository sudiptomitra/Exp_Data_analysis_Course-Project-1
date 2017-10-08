## Exploratory Data Analysis - Week1- Assigmnent 1 
## Code by : Sudipto Mitra 
## File Name : Plot3.R
## Purpose : Plotting "Global Active Power" to Frequency for Period of 01-02 Feb 2007
## Dataset :  Uc Irvine Machine Learning Dataset


######################################################################################################

# Setwd and load data set to memory 

######################################################################################################
setwd("C:/Sudipto_BI/Sudipto/DataScience_coursera/Course_4_Exploratory_Data_analysis/Assg_1")
fh <- file("household_power_consumption.txt")
power_data <- read.table(fh,header = T, sep = ";", na.strings = "?")

######################################################################################################

# Seubseting Data based on Date & Joining Date time

######################################################################################################

power_data$Date <- as.Date(power_data$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
plot_data <- subset(power_data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
plot_data <- plot_data[complete.cases(plot_data),]

## Combine Date and Time column
dateTime <- paste(plot_data$Date, plot_data$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")
## Removing Date time
plot_data <- plot_data[ ,!(names(plot_data) %in% c("Date","Time"))]

## Add DateTime column
plot_data <- cbind(dateTime,plot_data)

# Format dateTime Column
plot_data$dateTime <-  as.POSIXct(dateTime)

######################################################################################################

# Plot 3 : Submetering Plot vs Time 

######################################################################################################
png("plot3.png",width = 480, height = 480)
columnlines <- c("black", "red", "blue")
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
with(plot_data, plot(dateTime,Sub_metering_1,type = "l",col = columnlines[1], xlab = "", ylab = "Energy sub metering"))
lines(plot_data$dateTime,plot_data$Sub_metering_2,type = "l",col = columnlines[2])
lines(plot_data$dateTime,plot_data$Sub_metering_3,type = "l",col = columnlines[3])
legend("topright", legend=labels, col=columnlines, lty="solid")
dev.off()
