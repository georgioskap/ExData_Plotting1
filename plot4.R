### Get data (same on every R file in this project)

fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileZip = "exdata-data-household_power_consumption.zip"
fileTxt = "household_power_consumption.txt"

if (!file.exists(fileTxt)) {
  download.file(fileUrl, destfile=fileZip, method="curl")
  unzip(fileZip) 
}


### Read data, keep the two days we need and create the DateTime column (same on every R file in this project)

hh_all <- read.table(fileTxt, sep=";", header=TRUE, na.strings="?")
hh_2d <- hh_all[as.character(hh_all[,1])=="1/2/2007" | as.character(hh_all[,1])=="2/2/2007",]
hh_2d$DateTime <- strptime(paste(hh_2d$Date, hh_2d$Time),format="%d/%m/%Y %H:%M:%S")


### Create Plot 4 straight to PNG

png(file = "plot4.png")
par(mfrow = c(2, 2))

# Top Left
plot(hh_2d$DateTime,hh_2d$Global_active_power, type="n",xlab="",ylab="Global Active Power")
lines(hh_2d$DateTime,hh_2d$Global_active_power,col="black")

# Top Right
plot(hh_2d$DateTime,hh_2d$Voltage, type="n",xlab="datetime",ylab="Voltage")
lines(hh_2d$DateTime,hh_2d$Voltage,col="black")

# Bottom Left
plot(hh_2d$DateTime,hh_2d$Sub_metering_1, type="n",xlab="",ylab="Energy sub metering")
for (i in 1:3) { lines(hh_2d$DateTime,hh_2d[,6+i],col=colors[i]) }
legend("topright", lty=1, names(hh_2d[,7:9]), lwd=1, col=colors, bty="n")

#Bottom Right
plot(hh_2d$DateTime,hh_2d$Global_reactive_power, type="n",xlab="datetime",ylab="Global_reactive_power")
lines(hh_2d$DateTime,hh_2d$Global_reactive_power,col="black")

dev.off()
