if (!file.exists("./Exploratory Data Analysis")) {
        dir.create("./Exploratory Data Analysis")
}

if (!file.exists("./Exploratory Data Analysis/Plot1")) {
        dir.create("./Exploratory Data Analysis/Plot1")
}

## Download and Exract Files:  This step downloads the zipped project file from the web.  It then unzips the file 
## and extracts all project files into the directory created in the step above.
projectFile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(projectFile, destfile = "./Exploratory Data Analysis/household_power_consumption.zip")
unzip("./Exploratory Data Analysis/household_power_consumption.zip", files = NULL, exdir = "./Exploratory Data Analysis", 
      overwrite = TRUE)

##  Read in only the records that are between Feb. 1, 2007 and Feb. 2, 2007
datafile <- read.table("./Exploratory Data Analysis/household_power_consumption.txt", header=F, sep=";", 
                       skip = 66637, nrows = 2880)
options(max.print=999999)

##  Assign column names to the dataframe
colnames(datafile) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                        "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", 
                        "Sub_metering_3")

## Create a histogram of the Global Active Power
library(datasets)
hist(datafile$Global_active_power, xlab="Global Active Power (kilowatts)",
     main="Global Active Power", col="grey30", xlim=c(0,6), ylim=c(0, 1200))
dev.copy(png, file = "./Exploratory Data Analysis/Plot1/plot1.png", width=480, height=480)  ## Copy my plt to a PNG file
dev.off()  ## Close the PNG device
