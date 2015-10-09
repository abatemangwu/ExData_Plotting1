library(chron)

# plot2.R
# Global Active Power v. Datetime
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

png("plot2.png")
tics <- c(1,2,3)
labs <- c("Thu","Fri","Sat")
gapRange <- range(0,hpcDates$Global_active_power)
dateRange <- as.Date(c('2007-02-01', '2007-02-02', '2007-02-03'))
par(mar=c(4, 4, 4, 4) + 0.5)
plot(hpcDates$dateTime,hpcDates$Global_active_power, type="l", ylim=gapRange,  xaxt='n',xlab='', ylab='Global Active Power (kilowatts)')
axis(1, at=dateRange,lab=labs)
dev.off()



