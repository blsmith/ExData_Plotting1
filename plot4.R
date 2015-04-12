infile <- file("household_power_consumption.txt")

# Only use data from the dates 2007-02-01 and 2007-02-02
df <- read.csv(text = grep("^[1,2]/2/2007", readLines(infile), value=T), sep=';', na.strings="?", header=T, col.names = c("Date", "Time", "Global_Active_Power", "Global_Reactive_Power", "Voltage", "Global_Intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

# Converting dates
datetime <- paste(as.Date(df$Date), df$Time)
df$Datetime <- as.POSIXct(datetime)

# Create Plot
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))

with(df, {
  plot(Global_Active_Power ~ Datetime, type = "l", ylab = "Global Active Power", xlab = "")
  
  plot(Voltage ~ Datetime, type = "l", ylab = "Voltage", xlab = "datetime")
  
  plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Energy sub metering", xlab = "")
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')
  
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
    bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(Global_Reactive_Power ~ Datetime, type = "l", ylab = "Global_rective_power", xlab = "datetime")
})

# Save to a file
dev.copy(png, file="plot4.png")

dev.off()
