# To subset the data from the gigantic text file, I sampled the file to find rough parameters
# for the rows required and then subset the data again precisely for the data in the assignment

work <- read.table("household_power_consumption.txt",sep=";",header=TRUE,skip=65000,nrow=5000)

# This approach loses the column headers, so I run read.table() again, but only the first
# few lines to speed up the process, and extract the column headers with the next line of code.

col.names <- colnames(read.table("household_power_consumption.txt",sep=";",header=TRUE,nrow=5))

# Before subsetting, I asssign the column names to the data extracted from the file and then
# reclassify the Date column from factor to date/time using the strptime function.

names(work)[1:9] <- col.names
work$Date <- strptime(paste(work$Date,work$Time),"%d/%m/%Y %H:%M:%S")

# Subset the data for the days required by the assignment.  Helpful link:
# http://stats.stackexchange.com/questions/3997/subsetting-a-data-frame-in-r-based-on-dates

data <- work[work$Date>=as.POSIXlt("2007-02-01") & work$Date<as.POSIXlt("2007-02-03"),]

# plot 4

# Set up output to file for 1 page with a 2 x 2 lattice of graphs
png(filename ="plot4.png", width = 480, height = 480, units = "px", pointsize = 12)
par(mfrow = c(2,2))

# plot upper left graph (same as plot 2)
plot(data[,1], data[,3],
     type ="l",      # specifies line graph; plot returns scatterplot without this
     col  = "black",
     lwd  = 1,       # I think the default is 1, but I put this in anyway
     xlab = "",      # Removes data$Date from the x-label
     ylab = "Global Active Power")

# plot upper right graph
plot(data[,1], data[,5],
     type ="l",      # specifies line graph; plot returns scatterplot without this
     col  = "black",
     lwd  = 1,       
     xlab = "datetime",     
     ylab = "Voltage")

# plot lower left graph (same as plot 3)
plot(data[,1],data[,7], 
     type = "l", 
     col  = "black",
     xlab = "",
     ylab = "Energy sub metering")
lines(data[,1],data[,8], type = "l", col ="red")
lines(data[,1],data[,9], type = "l", col = "blue")
legend("topright",
       names(c(data[7],data[8],data[9])),
       bty  = "n",  # this removes the box around the legend in plot 3
       lty  = 1,
       col  = c("black","red",'blue'),
       cex  = .75)

# plot lower right graph
plot(data[,1], data[,4],
     type ="l",      # specifies line graph; plot returns scatterplot without this
     col  = "black",
     lwd  = 1,       
     xlab = "datetime",     
     ylab = "Global_reactive_power")

dev.off()
