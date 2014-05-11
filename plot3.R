# download file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./household_power_consumption.zip", method = "curl")

# read file
df <- read.csv(unz("household_power_consumption.zip", "household_power_consumption.txt"), sep = ";", stringsAsFactors = FALSE)

# subset to just Feb 1st and 2nd 2007
df <- subset(df, Date %in% c("1/2/2007", "2/2/2007"))

# create new column combining date and time values
df$datetime <- paste(df$Date, df$Time)

# convert new field to date
df$datetime <- strptime(df$datetime, format = "%d/%m/%Y %H:%M:%S")

# convert select variables to numeric
df[,3:9] <- apply(df[,3:9], 2, function(x) as.numeric(x))

# plot 3
png(file = "plot3.png", width = 480, height = 480, units = "px")

plot(x = df$datetime, y = df$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(df$datetime, df$Sub_metering_2, type = "l", col = 2)
lines(df$datetime, df$Sub_metering_3, type = "l", col = 4)
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c(1,2,4))

dev.off()