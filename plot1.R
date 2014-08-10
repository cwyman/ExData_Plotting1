# The txt file "household_power_consumption.txt" is located in the home directory.  To subset 
# the data from it, I sampled the file to find rough parameters for the rows required 
# and then subset the data again precisely for the data required in the assignment.

work <- read.table("household_power_consumption.txt",sep=";",header=TRUE,skip=65000,nrow=5000)

# This approach loses the column headers, so I run read.table() again, but only the first
# few lines to speed up the process, and extract the column headers with the next line of code.

col.names <- colnames(read.table("household_power_consumption.txt",sep=";",header=TRUE,nrow=5))

# Before subsetting, I asssign the column names to the data extracted from the file and then
# reclassify the Date column from factor to date/time using the strptime function.

names(work)[1:9] <- col.names
work$Date <- strptime(paste(work$Date,work$Time),"%d/%m/%Y %H:%M:%S")

# I then subset the data for the days required by the assignment.  Helpful link:
# http://stats.stackexchange.com/questions/3997/subsetting-a-data-frame-in-r-based-on-dates

data <- work[work$Date>=as.POSIXlt("2007-02-01") & work$Date<as.POSIXlt("2007-02-03"),]

#create plot

png(filename ="plot1.png", width = 480, height = 480, units = "px", pointsize = 9)
plot1 <- hist(data[,3],
     col     = "red",
     main    = "Global Active Power",
     xlab    = "Global Active Power (kilowatts)",
     ylab    = "Frequency")
dev.off()




