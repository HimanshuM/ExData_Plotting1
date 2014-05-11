# Script assumes the data file is in current working directory.

# Read-in the data from the file using sqldf package to read
# only the data in specified data range.
mySql <- "SELECT * FROM file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
Data <- read.csv.sql("household_power_consumption.txt", mySql, sep = ';')

# Now we work on Date and Time:
DateTime <- paste(Data$Date, Data$Time, sep = " ")
DateTime <- strptime(DateTime, "%d/%m/%Y %H:%M:%S")

# Add the DateTime variable to the data.frame and remove the old variables:
Data <- cbind(DateTime, Data)
Data <- Data[, c(-2, -3)]

# Finally we plot the third plot:
par(mfrow = c(2, 2))
# 1.
plot(Data$DateTime, Data$Global_active_power, type = "l", col = "Black",
     xlab = "", ylab = "Global Active Power")
# 2.
plot(Data$DateTime, Data$Voltage, type = "l", col = "Black", xlab = "datetime",
     ylab = "Voltage")
# 3.
plot(Data$DateTime, Data$Sub_metering_1, type = "l", col = "Black", xlab = "",
     ylab = "Energy sub metering")
lines(Data$DateTime, Data$Sub_metering_2, col = "Red")
lines(Data$DateTime, Data$Sub_metering_3, col = "Blue")
legend("topright", legend = c("Sub_metering_1", "sub_metering_2", "Sub_metering_3"),
       lwd = 1, col = c("Black", "Red", "Blue"), bty = "n")
# 4.
plot(Data$DateTime, Data$Global_reactive_power, type = "l", col = "Black",
     xlab = "datetime", ylab = "Global_reactive_power")
dev.off()
