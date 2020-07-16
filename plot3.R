library(dplyr)

if (!file.exists("household_power_consumption.txt")) {
        download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                      destfile = "exdata%2Fdata%2Fhousehold_power_consumption.zip",
                      method = "curl")
        unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip")
}


hpc <- read.table("household_power_consumption.txt",
                  header = TRUE,
                  sep = ";",
                  na.strings = "?") %>%
        as_tibble() %>%
        filter(Date == "1/2/2007" | Date == "2/2/2007")


hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")
hpc$Time <- strptime(paste(hpc$Date, hpc$Time, sep = " "), format = "%Y-%m-%d %H:%M:%S")

png("plot3.png")
plot(hpc$Time, hpc$Sub_metering_1, type = "l", ann = FALSE)
points(hpc$Time, hpc$Sub_metering_2, type = "l", col = "red")
points(hpc$Time, hpc$Sub_metering_3, type = "l", col = "blue")
title(ylab = "Energy Sub Metering")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = names(hpc)[7:9])
dev.off()