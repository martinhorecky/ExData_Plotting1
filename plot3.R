# Read data from file - ensure that data file is in the working directory
full_data = read.csv("household_power_consumption.txt", colClasses = c("character", "character", "character", "character", "character", "character", "character", "character", "character"), sep = ";")

# Filter out two dates into two separate data sets
filtered_1 = full_data[full_data$Date == "1/2/2007",]
filtered_2 = full_data[full_data$Date == "2/2/2007",]

# Join the two dates into single data set (2880 rows)
data <- rbind(filtered_1, filtered_2)

# Convert Global_active_power to numberic
data$Sub_metering_1 <- sapply(data$Sub_metering_1, as.numeric)
data$Sub_metering_2 <- sapply(data$Sub_metering_2, as.numeric)
data$Sub_metering_3 <- sapply(data$Sub_metering_3, as.numeric)
# Convert Data and Time into singe Date field
data$Date <- strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")


png(file="plot3.png", width=480, height=480)
plot(data$Date, data$Sub_metering_1, type="s", xlab="", ylab="Energy sub metering")
lines(data$Date, data$Sub_metering_2, type="s", col="red")
lines(data$Date, data$Sub_metering_3, type="s", col="blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
