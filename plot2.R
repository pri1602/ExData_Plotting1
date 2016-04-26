#Plotting time series data
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
data_plot2 <- subset(data1, Date>"2007-02-01" & Date < "2007-02-03")
#Transforming Global_active_power variable from character to numeric.
data_plot2$Global_active_power <- as.numeric(data_plot2$Global_active_power)
#Transforming Global_active_power into a time series variable with frequency of 1440
# helpful links
#http://a-little-book-of-r-for-time-series.readthedocs.org/en/latest/src/timeseries.html 
#http://stats.stackexchange.com/questions/120806/frequency-value-for-seconds-minutes-intervals-data-in-r
data_plot2$Global_active_power <- ts(data_plot2$Global_active_power, frequency=1440)
png(file="plot2.png")
#plot.ts used to plot time series data. xlab"" suppresses the xlabel,xaxt='n' suppresses the default axis ticks.
#Helpful link 
#http://www.statmethods.net/advgraphs/axes.html
plot.ts(data_plot2$Global_active_power, xlab="", ylab= "Global Active Power(kilowatts)", xaxt="n")
axis(1, at=c(1,2,3), labels=c("Thursday", "Friday", "Saturday"))
dev.off()




