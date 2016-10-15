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

##STEP 4: Subset the various energy power consumption data for plotting

submeter1<- as.numeric(powerusage$Sub_metering_1) 
submeter2<- as.numeric(powerusage$Sub_metering_2) 
submeter3<- as.numeric(powerusage$Sub_metering_3)
globalActivePower <- as.numeric(powerusage$Global_active_power)
globalReactivePower <- as.numeric(powerusage$Global_reactive_power)
Voltage <- as.numeric(powerusage$Voltage)

##STEP5: Plot the various Energy Power Consumption data (Plot No. 4)

###set the device to plot first
png("plot4.png", width=480, height=480)

par(mfcol=c(2,2), mar=c(4,4,2,2))
plot(DateTime, globalActivePower, type="l", xlab="", ylab="Global Active Power")
plot(DateTime, submeter1, ylab="Energy sub metering", xlab="", type = "l")
lines(DateTime, submeter2, col = 'red')
lines(DateTime, submeter3, col = 'blue')
legend('topright', col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd = 1)
plot(DateTime, Voltage, type="l", ylab="Voltage", xlab="datetime")
plot(DateTime, globalReactivePower, type="l", ylab="Global_reactive_power",xlab="datetime")

dev.off()
