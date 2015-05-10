library(data.table)
library(dplyr)

# reading the whole dataset
HPC <- fread("./data/household_power_consumption.txt", na.strings = "?")
# creating subset of the given dates
HPC2 <- filter(HPC, Date == "1/2/2007" |  Date == "2/2/2007")


# Reformatting the date & time, adding a new column
HPC2$Date <- as.Date(HPC2$Date, format="%d/%m/%Y")
date_time <- paste(as.Date(HPC2$Date), HPC2$Time)
HPC2 <- mutate(HPC2,  dateTime = as.POSIXct(date_time))


# Construcing plot 4

# Splitting the space
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
# Creating the plots
with(HPC2, {
  # 1st
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  # 2nd
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  # 3rd
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime, col='Red')
  lines(Sub_metering_3~dateTime, col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  # 4th
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

# Creating the file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()