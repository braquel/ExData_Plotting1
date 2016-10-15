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

##STEP 4: Subset the Submetering data for various household activities

submeter1<- as.numeric(powerusage$Sub_metering_1) ###kitchen 
submeter2<- as.numeric(powerusage$Sub_metering_2) ###laundry room
submeter3<- as.numeric(powerusage$Sub_metering_3) ### ambient settings

##STEP: Plot the submetered power consumption data across the date range (Plot No. 3)

####set the device to plot first
png("plot3.png", width=480, height=480)

plot(DateTime, submeter1, ylab="Energy sub metering", xlab="", type = "l")
lines(DateTime, submeter2, col = 'red')
lines(DateTime, submeter3, col = 'blue')
legend('topright', col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd = 1)
dev.off()
