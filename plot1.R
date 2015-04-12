infile <- file("household_power_consumption.txt")

# Only use data from the dates 2007-02-01 and 2007-02-02
df <- read.csv(text = grep("^[1,2]/2/2007", readLines(infile), value=T), sep=';', na.strings="?", header=T, col.names = c("Date", "Time", "Global_Active_Power", "Global_Reactive_Power", "Voltage", "Global_Intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Create Plot
hist(df$Global_Active_Power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# Save to a file
dev.copy(png, file="plot1.png")

dev.off()
