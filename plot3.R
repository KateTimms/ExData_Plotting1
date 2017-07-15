# Doanload file and unzip
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, "powerconsumption.zip")
unzip("powerconsumption.zip")

# Read file into R
powerconsumption <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?", stringsAsFactors = FALSE)

# Subset out only the wanted dates
powerconsumptions <- subset(powerconsumption, powerconsumption$Date == "1/2/2007")
powerconsumptions <- rbind(powerconsumptions, subset(powerconsumption, powerconsumption$Date == "2/2/2007"))

# create a merged date and time column in date class
powerconsumptionstwo <- mutate(powerconsumptions, dateTime = as.POSIXct(paste(powerconsumptions$Date, powerconsumptions$Time), format = "%d/%m/%Y %H:%M:%S"))

#plot the plot to a png
png("plot3.png",width = 480, height = 480)
with(powerconsumptionstwo, plot(Sub_metering_1 ~ dateTime, lty="solid", type = "l", ylab = "Energy sub metering", xlab = ""))
par(points(powerconsumptionstwo$Sub_metering_2 ~ powerconsumptionstwo$dateTime, lty="solid", type = "l", col="red"))
par(points(powerconsumptionstwo$Sub_metering_3 ~ powerconsumptionstwo$dateTime, lty="solid", type = "l", col="blue"))
par(legend("topright", lty = c(1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")))
dev.off()