infile <- file("household_power_consumption.txt")

# Only use data from the dates 2007-02-01 and 2007-02-02
df <- read.csv(text = grep("^[1,2]/2/2007", readLines(infile), value=T), sep=';', na.strings="?", header=T, col.names = c("Date", "Time", "Global_Active_Power", "Global_Reactive_Power", "Voltage", "Global_Intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

# Converting dates
datetime <- paste(as.Date(df$Date), df$Time)
df$Datetime <- as.POSIXct(datetime)

# Create Plot
with(df, {
  plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Energy sub metering", xlab = "")
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')
})

legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Save to a file
dev.copy(png, file="plot3.png")

dev.off()
