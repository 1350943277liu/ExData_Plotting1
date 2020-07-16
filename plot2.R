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

png("plot2.png")
plot(hpc$Time, hpc$Global_active_power, type = "l", ann = FALSE)
title(ylab = "Global Active Power (kilowatts)")
dev.off()