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


### Create Plot 2 straight to PNG

png(file = "plot2.png")
plot(hh_2d$DateTime,hh_2d$Global_active_power, type="n",xlab="",ylab="Global Active Power (kilowatts)")
lines(hh_2d$DateTime,hh_2d$Global_active_power,col="black")
dev.off()