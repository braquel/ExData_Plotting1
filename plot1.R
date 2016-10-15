
## library(data.table)

##Step 1: Read data file
rootdata <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", stringsAsFactors=FALSE, dec=".")

##STEP2: Subset by date coverage
powerusage<- rootdata[rootdata$Date %in% c("1/2/2007","2/2/2007") ,]
rownames(powerusage) <- c()

##STEP3: Convert to DATE\TIME CLASSES using as.Date() and strptime() functions
powerusage$Date <- as.Date(powerusage$Date, format="%d/%m/%Y")

##STEP 4: Plot the data for Global Active power usage (Plot No. 1)
png("plot1.png", width=480, height=480) #set the device to plot first

hist(powerusage$Global_active_power, main="Global Active Power", col="Red", xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off() ##don't forget to close the device

