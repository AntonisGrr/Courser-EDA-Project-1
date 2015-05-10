

library(data.table)
library(dplyr)

# reading the whole dataset
HPC <- fread("./data/household_power_consumption.txt", na.strings = "?")
# creating subset of the fiven dates
HPC2 <- filter(HPC, Date == "1/2/2007" |  Date == "2/2/2007")


# Construcing plot 1

GAP<- as.numeric(HPC2$Global_active_power)
png("plot1.png", width=480, height=480)
hist(GAP, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "red")

dev.off()