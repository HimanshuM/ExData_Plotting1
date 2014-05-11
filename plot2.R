# Script assumes the data file is in currect working directory.

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

# Now we plot the second plot:
png("plot2.png")
plot(Data$DateTime, Data$Global_active_power, type = "l", col = "Black",
     xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
