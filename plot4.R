##########################################################################################################################
## Creates the following 4 graphs and saves is to a PNG file:                                                           ##
## 1. Global Active Power" as function of time                                                                          ##
## 2. Voltage as function of time                                                                                       ##
## 3. Energy sub metering as function of time                                                                           ##
## 4. Global rective power as function of time                                                                          ##   
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
png("plot4.png", width = 480, height = 480, units = "px", bg = "white")
#Concatenate date and time
date_time <- paste(data$Date, data$Time)
#convert into a date time object and add as a column to the data table
data$DateTime <- strptime(date_time, format="%d/%m/%Y %H:%M:%S", tz = "") 
#set 2 on 2 graphs display. Set mar and oma to adjust margins of the graphs
par(mfrow = c(2,2), mar = c(4,4,4,1), oma = c(1,1,0,0))
#plot the data
with(data, {
        #graph #1
        plot(DateTime, Global_active_power, type = "l",  ylab = "Global Active Power", xlab = "")
        #graph #2
        plot(DateTime, Voltage, type = "l", ylab = "Voltage", xlab = "datetime") 
        #graph #3
        plot(DateTime,Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
        lines(DateTime, Sub_metering_2, col = 'Red') 
        lines(DateTime, Sub_metering_3, col = 'Blue')
        #Add legend without a box outline
        legend("topright", 
               col = c("black", "red", "blue"),
               bty = "n",
               lty = 1, lwd = 2, 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        #graph #4
        plot(DateTime, Global_reactive_power, type = "l",  ylab = "Global_rective_power", xlab = "datetime") 
})

#close device connection
dev.off()
