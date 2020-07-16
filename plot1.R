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

# since default dimension is 480*480, as required, no need to set it explicitly. 
# The same reason for plot2 to plot4.

png("plot1.png") 
hist(hpc$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power(kilowatts)", 
     col = "red")
dev.off()
