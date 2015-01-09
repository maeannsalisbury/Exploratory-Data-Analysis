if (!file.exists("./Exploratory Data Analysis")) {
        dir.create("./Exploratory Data Analysis")
}

if (!file.exists("./Exploratory Data Analysis/Plot4")) {
        dir.create("./Exploratory Data Analysis/Plot4")
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

## Add colukn with weekday value of the date
datafile$DateTime <- as.POSIXct(paste(datafile$Date, datafile$Time), format="%d/%m/%Y %H:%M:%S")

## Create four distinct graphs on same page
library(datasets)
par(mfcol=c(2,2))

## Plot a line graph of the Global Active Power plotted over days
with(datafile, plot(DateTime, Global_active_power, type="l", xlab="", ylab = "Global Active Power (kilowatts)"))

## Create a second line graph of the three separate Energy sub metering points
with(datafile, plot(DateTime, Sub_metering_1, type="s", col="black", xlab="", ylab="Energy sub metering"))
with(datafile, points(DateTime, Sub_metering_2, type="s", col="red"))
with(datafile, points(DateTime, Sub_metering_3, type="s", col="blue"))
legend("topright", lty=c(1, 1, 1), col=c("black", "red", "blue"), legend=c("Sub_metering_1",
                                                                           "Sub_metering_2",
                                                                           "Sub_metering_3"))

## Create a third line graph of the Voltage plotted over date and time
with(datafile, plot(DateTime, Voltage, type="l", xlab="datetime", ylab = "Voltage"))

## Create the fourth and last line graph of the Global Reactive Power plotted over time
with(datafile, plot(DateTime, Global_reactive_power, type="l", xlab="datetime", ylab = "Global_reactive_power"))

dev.copy(png, file = "./Exploratory Data Analysis/Plot4/plot4.png", width=480, height=480)  ## Copy my plt to a PNG file
dev.off()  ## Close the PNG device
