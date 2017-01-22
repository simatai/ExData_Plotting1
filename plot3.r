
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

## Plot 3: Energy Sub-metering
# please note that I have a non-us locale, which is why German labels for weekdays are shown in the PNG

plot(elcons$datetime,elcons$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(elcons$datetime,elcons$Sub_metering_2,col="red")
lines(elcons$datetime,elcons$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3"),
       lty=c(1,1), lwd=c(1,1))
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
