## library(data.table)

##Step 1: Read data file
rootdata <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", stringsAsFactors=FALSE, dec=".")

##STEP2: Subset by date coverage
powerusage<- rootdata[rootdata$Date %in% c("1/2/2007","2/2/2007") ,]
rownames(powerusage) <- c()

##STEP3: Convert to DATE\TIME CLASSES using as.Date() and strptime() functions
powerusage$Date <- as.Date(powerusage$Date, format= "%d/%m/%Y")
powerusage$DateTime <- paste(as.Date(powerusage$Date), powerusage$Time)
DateTime<- as.POSIXlt(powerusage$DateTime)

##STEP4: Subset the Global Active Power Data

globalActivePower <- as.numeric(powerusage$Global_active_power)

##STEP5: Plot Global Active Power Data (Plot No. 2)
  
###set the device to plot first
png("plot2.png", width=480, height=480)

plot(DateTime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off() ##don't forget to close the device

