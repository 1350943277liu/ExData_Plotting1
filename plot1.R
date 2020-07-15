library(dplyr)

if (!file.exists("household_power_consumption.txt")) {
        download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                      destfile = "exdata%2Fdata%2Fhousehold_power_consumption.zip",
                      method = "curl")
        unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip")
}

household_power_consumption <- read.table("household_power_consumption.txt",
                                          header = TRUE,
                                          sep = ";",
                                          na.strings = "?") %>%
                               as_tibble() %>%
                               filter(Date == "1/2/2007" | Date == "2/2/2007")

household_power_consumption$Date <- as.Date(household_power_consumption$Date, 
                                            format = "%d/%m/%Y")

household_power_consumption$Time <- strptime(paste(household_power_consumption$Date, 
                                                   household_power_consumption$Time, 
                                                   sep = " "),
                                             format = "%Y-%m-%d %H:%M:%S")

hist(household_power_consumption$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power(kilowatts)", 
     col = "red")

