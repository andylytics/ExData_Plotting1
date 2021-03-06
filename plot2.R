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

# plot 2
png(file = "plot2.png", width = 480, height = 480, units = "px")
plot(x = df$datetime, y = df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
