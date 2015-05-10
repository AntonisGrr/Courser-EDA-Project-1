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

# Construcing plot 3
with(HPC2, { plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
      lines(Sub_metering_2~dateTime,col='Red')
      lines(Sub_metering_3~dateTime,col='Blue')
})
# adding the legend
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


# Creating the file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()