# Read data from file - ensure that data file is in the working directory
full_data = read.csv("household_power_consumption.txt", colClasses = c("character", "character", "character", "character", "character", "character", "character", "character", "character"), sep = ";")

# Filter out two dates into two separate data sets
filtered_1 = full_data[full_data$Date == "1/2/2007",]
filtered_2 = full_data[full_data$Date == "2/2/2007",]

# Join the two dates into single data set (2880 rows)
data <- rbind(filtered_1, filtered_2)

# Convert Global_active_power to numberic
data$Global_active_power <- sapply(data$Global_active_power, as.numeric)
# Convert Data and Time into singe Date field
data$Date <- strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")

png(file="plot2.png", width=480, height=480)
plot(data$Date, data$Global_active_power, type="s", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

