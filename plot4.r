
dataFile <- "D:/Documents/R/data-science/exploratory/prj_1/household_power_consumption.txt"

# read the file in its entirety
# If anyone has figured out a solution for selective read with read.csv.sql, I'd be grateful for a message!
elcons <- read.table(dataFile, header = T, sep = ";", na.strings = "?")

# convert the date variable to Date class
elcons$Date <- as.Date(elcons$Date, format = "%d/%m/%Y")

# subset the data (and free memory...)
elcons <- subset(elcons, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

# convert dates and times
elcons$datetime <- strptime(paste(elcons$Date, elcons$Time), "%Y-%m-%d %H:%M:%S")

## Plot 4: putting several plots together
# please note that I have a non-us locale, which is why German labels for weekdays are shown in the PNG

# initialize 2x2 plot pane
par(mfrow=c(2,2))

# call plot for each pane
plot(elcons$datetime,elcons$Global_active_power, type="l",  xlab="", ylab="Global Active Power")  

plot(elcons$datetime,elcons$Voltage, type="l",xlab="datetime",ylab="Voltage")

plot(elcons$datetime,elcons$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
lines(elcons$datetime,elcons$Sub_metering_1)
lines(elcons$datetime,elcons$Sub_metering_2,col="red")
lines(elcons$datetime,elcons$Sub_metering_3,col="blue")
legend("topright", lty=1, col=c("black","red","blue")
       ,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)

plot(elcons$datetime,elcons$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
