# Plot4.R
### PART 1: READING THE DATA ###
# Set column classes according to README.md
colClasses <- c("character","character",rep("numeric",7))
# Set "?" to be NAs
naStrings <- "?"
powerData <- read.csv(file="household_power_consumption.txt", 
                      sep=";",
                      header = TRUE,
                      colClasses = colClasses, 
                      na.strings = naStrings)
# Make POSIXlt variable with "Date" and "Time" strings, overwrite "Time" column
powerData$Time <- with(powerData, 
                       strptime(paste(Date,Time),
                                format="%d/%m/%Y %H:%M:%S"))

# Make Date variable with "Date" strings, overwrite "Date" column
powerData$Date <- with(powerData, 
                       as.Date(Date, 
                               format="%d/%m/%Y"))

# Get data from the dates 2007-02-01 and 2007-02-02
twoDayPeriod <- with(powerData, 
                     powerData[Date == "2007-02-01" | Date == "2007-02-02",])

### PART 2: Constructing the plot ###
# Open file connection
png("plot4.png")
par(mfrow=c(2,2))
with(twoDayPeriod,
     { 
       plot(x = Time, 
            y = Global_active_power, 
            ylab = "Global Active Power",
            xlab = "",
            type="l")
       plot(x=Time, y=Voltage, type="l",xlab="datetime")
       plot(xlab="", ylab="Energy sub metering", type="l",
             x = Time, y = Sub_metering_1, col="black")
       lines(x = Time, y = Sub_metering_2, col="red")
       lines(x = Time, y = Sub_metering_3, col="blue")
       legend(x="topright",
               legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
               lty = 1, col = c("black", "red","blue"), bty="n")
     
     plot(x=Time, y=Global_reactive_power, type="l",xlab="datetime")
       }
     )
dev.off()