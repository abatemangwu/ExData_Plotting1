library(chron)

# plot4.R
# Combination Plot:
#   Global Active Power v. Datetime
#   Voltage v. Datetime
#   Sub Metering (3 variables) v. Datetime
#   Global Reactive Power v Datetime
#
# R scripts to create various exploratory plots
# Submission for Exploratory Data Analysis, Project 1
# Anthony Bateman
# abateman@gwu.edu
# Oct 9, 2015


# Load the dataset.
# Cast Date and Time variables to chron class and format.
# Subset the raw dataset (household_power_consumption.txt) to specific dates.
# Save the results to a file for good measure.

if (!file.exists("data/hpcDates.Rda")){
  class <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
  hpc <- read.csv("data/household_power_consumption.txt", sep = ";", as.is = TRUE, colClasses = class, na.strings=c("?"))
  hpc$dateTime <- chron(dates. = hpc$Date, times. = hpc$Time, format = c(dates = "d/m/y", times = "h:m:s"))
  hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")
  hpcDates <- hpc[hpc$Date %in% as.Date(c('2007-02-01', '2007-02-02')),]
  saveRDS(hpcDates, file="data/hpcDates.Rda")
} else {
  hpcDates <- readRDS(file="data/hpcDates.Rda")
}


# Create some defaults
tics <- c(1,2,3)
labs <- c("Thu","Fri","Sat")

# date range for x-axis label
dateRange <- as.Date(c('2007-02-01', '2007-02-02', '2007-02-03'))

# various ranges for y-lim of plots
gapRange <- range(0,hpcDates$Global_active_power)
grpRange <- range(0,hpcDates$Global_reactive_power)
voltRange <- range(min(hpcDates$Voltage),max(hpcDates$Voltage))
biggestMeter <- max(c(max(hpcDates$Sub_metering_1),max(hpcDates$Sub_metering_2),max(hpcDates$Sub_metering_3)))
subMeterRange <- range(0,biggestMeter)


# Make a new png file
png("plot4.png")

#Graphics Parameters
par(
  mar=c(4, 4, 4, 4) + 0.25,
  mfrow=c(2,2),
  cex=0.64
)

# Global Active Power Plot
plot(hpcDates$dateTime,hpcDates$Global_active_power, type="l", ylim=gapRange,  xaxt='n',xlab='', ylab='Global Active Power')
axis(1, at=dateRange,lab=labs)

# Voltage Plot
plot(hpcDates$dateTime,hpcDates$Voltage, type="l", ylim=voltRange,  xaxt='n',xlab='Datetime', ylab='Voltage')
axis(1, at=dateRange,lab=labs)

# Sub Metering Plot
plot(
  hpcDates$dateTime,
  hpcDates$Sub_metering_1,
  ylim=subMeterRange,
  type='l',
  ylab='Energy sub metering',
  xaxt='n',
  xlab='',
  col='black'
)
lines(hpcDates$dateTime, hpcDates$Sub_metering_2,col='red')
lines(hpcDates$dateTime, hpcDates$Sub_metering_3, type='l', col='blue')
axis(1, at=dateRange,lab=labs)
legend (
  'topright',
  legend = c('Sub Metering 1','Sub Metering 2','Sub Metering 3'),
  col=c("black", "red", "blue"),
  lty=c(1,1,1)
)


# Global Reactive Power Plot
plot(hpcDates$dateTime,hpcDates$Global_reactive_power, type="l", ylim=grpRange,  xaxt='n',xlab='Datetime', ylab='Global Reactive Power')
axis(1, at=dateRange,lab=labs)

dev.off()
