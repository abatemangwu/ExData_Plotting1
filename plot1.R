library(chron)

# plot1.R
# Histogram Global Active Power v. (freq)
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

png("plot1.png")
par()
hist(hpcDates$Global_active_power,
    main = "Global Active Power",
    xlab = "Global Active Power (kilowatts)",
    ylab = "Frequency",
    col = "red"
)

dev.off()

