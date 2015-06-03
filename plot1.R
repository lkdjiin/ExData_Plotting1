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

# Creating and saving the graph.
png(filename='plot1.png', width=480, height=480)
hist(d$Global_active_power, col='red', xlab='Global Active Power (kilowatts)',
     main='Global Active Power')
dev.off()
