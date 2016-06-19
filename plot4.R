##########
# Plot 4 
##########

#Set Working Dir
setwd("C:/Users/Michael/ExData_Plotting1")

#Set Locals
filepath = "C:\\Users\\Michael\\Documents\\Education and Training\\Coursera - Exploritory Data Analysis\\R_Working\\household_power_consumption.txt"
col_classes = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
na_strings = c("?")

#Read in raw data
r_data <- read.delim(filepath, header = TRUE, sep = ";", colClasses = col_classes, na.strings = na_strings)

#Filter data to the required days
f_data <- r_data[(r_data$Date == "1/2/2007"| r_data$Date == "2/2/2007"),]  

#Release unnecessary memory
r_data <- NULL

#transform data for graphing (create a DateTime field)
t_data <- data.frame("Date_time" = strptime(paste(f_data$Date, f_data$Time), format = "%d/%m/%Y %H:%M:%S"),
                     "Global_active_power" = f_data$Global_active_power,
                     "Global_reactive_power" = f_data$Global_reactive_power,
                     "Voltage" = f_data$Voltage,
                     "Global_intensity" = f_data$Global_intensity,
                     "Sub_metering_1" = f_data$Sub_metering_1,
                     "Sub_metering_2" = f_data$Sub_metering_2,
                     "Sub_metering_3" = f_data$Sub_metering_3)


#create multiple graphs in grid formation
plt <-function(){
  par(mfrow = c(2,2))
  
  #1st quadrant
  y_axis_txt = "Global Active Power"
  plot(t_data$Global_active_power ~ t_data$Date_time , type = 'o', xlab = "", ylab = y_axis_txt, pch= NA)
  
  #2nd quadrant
  x_axis_txt = "datetime"
  y_axis_txt = "Voltage"
  plot( t_data$Voltage ~ t_data$Date_time, type = 'o', xlab = x_axis_txt, ylab = y_axis_txt, pch= NA)
  
  #3rd quadrant
  y_axis_txt = "Energy sub metering"
  plot(t_data$Sub_metering_1 + t_data$Sub_metering_2 + t_data$Sub_metering_3 ~ t_data$Date_time , type = 'n', xlab = "", ylab = y_axis_txt)
  lines(t_data$Date_time, t_data$Sub_metering_1, type = 'o', pch = NA, col = "black")
  lines(t_data$Date_time, t_data$Sub_metering_2, type = 'o', pch = NA, col = "red")
  lines(t_data$Date_time, t_data$Sub_metering_3, type = 'o', pch = NA, col = "blue")
  legend("topright", lty=1, cex = 0.8, seg.len = 1 , col = c("black","red", "blue"),legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
  
  #4th quadrant
  x_axis_txt = "datetime"
  y_axis_txt = "Global_reactive_power"
  plot(t_data$Global_reactive_power ~ t_data$Date_time, type = 'o', xlab = x_axis_txt, ylab = y_axis_txt, pch= NA)
}


#test plotting to screen
plt()

#plot plotting PNG
png(filename = "plot4.png", width = 480, height = 480, units = "px")
plt()
dev.off()

