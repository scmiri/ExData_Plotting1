##########################################################################################################################
## Plots Global Active Power as function of time and saves is to a PNG file                                             ##
##                                                                                                                      ##   
## To run the script:                                                                                                   ##
## 1. Download household_power_consumption.txt and copy to your working direcoty                                        ##         
## 2. Modify the setwd() line to point to your working directory                                                        ##
##                                                                                                                      ## 
##########################################################################################################################

#Set the working directory
setwd("D:\\R\\ExploratoryDataAnalysis\\Week1")

#Read only data for the dates February 1st, 2007 and February 2nd 2007 
fh <- file("household_power_consumption.txt") 
data <- read.table(text = grep("^[1,2]/2/2007", readLines(fh), value = TRUE), 
                   col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                   sep = ";", header = TRUE)
#close file handle
close(fh)

#open png device
png("plot2.png", width = 480, height = 480, units = "px", bg = "white")
#set margin
par(mar= c(5, 5, 4, 2))
#Concatenate date and time
date_time <- paste(data$Date, data$Time)
#convert into a date time object and add as a column to the data table
data$DateTime <- strptime(date_time, format="%d/%m/%Y %H:%M:%S", tz = "") 
#plot the data
plot(data$DateTime, 
     data$Global_active_power, 
     type = "l", 
     ylab = "Global Active Power (kilowatts)", 
     xlab = "")
#close device connection
dev.off()
