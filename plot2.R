# Please note that:
#
# - The sqldf package is required.
# - The file `household_power_consumption.txt` must be in your working
#   folder.

library(sqldf)

# Loading data.
d <- read.csv.sql('household_power_consumption.txt',
     sep=';',
     colClasses=c(rep('character', 2), rep('numeric', 7)),
     sql="select * from file where Date == '1/2/2007' or Date == '2/2/2007'")

# Building datetime column.
d$datetime <- paste(d$Date, d$Time)
d$datetime <- strptime(d$datetime, "%d/%m/%Y %H:%M:%S")

# Creating and saving the graph.
png(filename='plot2.png', width=480, height=480)
plot(d$datetime, d$Global_active_power, type='l', xlab='',
     ylab='Global Active Power (kilowatts)')
dev.off()
