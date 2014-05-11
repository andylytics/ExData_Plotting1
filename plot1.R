# NOTE: download the zip file from the following URL: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# extract/unzip the file so that the household_power_consumption.txt file is in
# your working directory

# read file
df <- read.csv("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE)

# subset to just Feb 1st and 2nd 2007
df <- subset(df, Date %in% c("1/2/2007", "2/2/2007"))

# create new column combining date and time values
df$datetime <- paste(df$Date, df$Time)

# convert new field to date
df$datetime <- strptime(df$datetime, format = "%d/%m/%Y %H:%M:%S")

# convert select variables to numeric
df[,3:9] <- apply(df[,3:9], 2, function(x) as.numeric(x))

# plot 1
png(file = "plot1.png", width = 480, height = 480, units = "px")
hist(df$Global_active_power, col = 2, main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()