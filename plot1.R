#Electric consumption data. Creating histogram of one variable.
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
data_plot1 <- subset(data1, Date>"2007-02-01" & Date < "2007-02-03")
data_plot1$Global_active_power <- as.numeric(data_plot1$Global_active_power)
png(file="plot1.png")
hist(data_plot1$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power(kilowatts)")
dev.off()






