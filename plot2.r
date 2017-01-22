
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

## Plot 2: Global active power time series
# please note that I have a non-us locale, which is why German labels for weekdays are shown in the PNG
plot(elcons$datetime,elcons$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)") 

dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
