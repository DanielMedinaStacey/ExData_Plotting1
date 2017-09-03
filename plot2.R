# Plot2.R
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
png("plot2.png")
with(twoDayPeriod, 
     plot(x = Time, 
          y = Global_active_power, 
          ylab = "Global Active Power (kilowatts)",
          xlab = "",
          type="l"))
# Close file connection
dev.off()
