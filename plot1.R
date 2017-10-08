## Exploratory Data Analysis - Week1- Assigmnent 1 
## Code by : Sudipto Mitra 
## File Name : Plot1.R
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

# Plot 1 : Global Active Power Frequency plotting to png file 

######################################################################################################
png("plot1.png",width = 480, height = 480)
hist(plot_data$Global_active_power,main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()
