#Layering of one plot over another.
setwd("~/R/Coursera/ExploratoryDataAnalysis/Course_Project1")
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
td <- tempdir()
tf <- tempfile(tmpdir=td, fileext=".zip") 
download.file(fileurl, tf)
fname <- unzip(tf)
data1 <- read.table(fname, header=TRUE, sep=";", stringsAsFactors = FALSE)

#Convert dates to dates and times format. I used lubridate. Can also use strptime()
# and as.Date()
library(lubridate)
data1$Date <- dmy(data1$Date)
data1$Time <- hms(data1$Time)

#Subset data1 by Dates from "2007-02-01" to "2007-02-02". If I dont use
#Date<"2007-02-03" it does not includethe observations of Feb2
data_plot3 <- subset(data1, Date>"2007-02-01" & Date < "2007-02-03")

#Converting Sub_metering variables into numeric
data_plot3$Sub_metering_1 <- as.numeric(data_plot3$Sub_metering_1)
data_plot3$Sub_metering_2 <- as.numeric(data_plot3$Sub_metering_2)
data_plot3$Sub_metering_3 <- as.numeric(data_plot3$Sub_metering_3)

#Converting Sub_metering variables into time series with frequencies of 1440.
#This is required so that the ticks are set at 24 hours each.So that we can 
#plot Thursday, Friday, saturday in the x axis and y axis.
#Since the data is in
#minute intervals, number of data units in one day = 24x60=1440. 
# helpful links
#http://a-little-book-of-r-for-time-series.readthedocs.org/en/latest/src/timeseries.html 
#http://stats.stackexchange.com/questions/120806/frequency-value-for-seconds-minutes-intervals-data-in-r
data_plot3$Sub_metering_1 <- ts(data_plot3$Sub_metering_1, frequency=1440)
data_plot3$Sub_metering_2 <- ts(data_plot3$Sub_metering_2, frequency=1440)
data_plot3$Sub_metering_3 <- ts(data_plot3$Sub_metering_3, frequency=1440)

#plot.ts used to plot time series data. xlab"" suppresses the xlabel,xaxt='n' suppresses the default axis ticks.
#Helpful link 
#http://www.statmethods.net/advgraphs/axes.html
# Also, ggplot can be used to layer plots. 
png(file="plot3.png")
plot.ts(data_plot3$Sub_metering_1, xlab="", ylab= "Energy sub metering", xaxt="n")
lines(data_plot3$Sub_metering_2, xlab="", ylab= "Energy sub metering", xaxt="n", col="red")
lines(data_plot3$Sub_metering_3, xlab="", ylab= "Energy sub metering", xaxt="n", col="blue")
axis(1, at=c(1,2,3), labels=c("Thursday", "Friday", "Saturday"))
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

