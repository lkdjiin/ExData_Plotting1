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
png(filename='plot4.png', width=480, height=480)
par(mfrow=c(2, 2))
with(d, {
  # Top left graph.
  plot(datetime, Global_active_power, xlab='', ylab='Global Active Power',
       type='l')

  # Top right graph.
  plot(datetime, Voltage, type='l')

  # Bottom left graph.
  plot(datetime, Sub_metering_1, type='l', xlab='', ylab='Energy sub metering')
  lines(datetime, Sub_metering_2, col='red')
  lines(datetime, Sub_metering_3, col='blue')
  legend('topright', names(d)[7:9], col=c('black', 'red', 'blue'), lty=1)

  # Bottom right graph.
  plot(datetime, Global_reactive_power, type='l')
})
dev.off()
