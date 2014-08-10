# Note : I am going to assume exdata_data_household_power_consumption.zip exists in the CWD

#Reads in the data, formats it nicely, then returns it as a data frame
ReadData <- function() 
{
  raw <- read.table(unzip("exdata_data_household_power_consumption.zip"), 
                    sep = ";", 
                    header = TRUE, 
                    stringsAsFactors = FALSE, 
                    colClasses = c("character", "character", rep("numeric", 7)), 
                    na.strings = "?");
  
  #Fix the date/time columns
  raw$DateTime <- strptime(paste(raw$Date, raw$Time), "%d/%m/%Y %H:%M:%S")
  raw$Date <- as.Date(raw$Date, "%d/%m/%Y");
  raw$Time <- as.POSIXct(strptime(raw$Time, "%H:%M:%S"));
  
  return(raw[which(raw$Date >= as.Date('2007-02-01') & raw$Date <= as.Date('2007-02-02')), ]);
}

GeneratePlot <- function()
{
  mat <- matrix(1:4, 2);
  layout(mat);
  plot(Data$DateTime, Data$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="");
  plot(Data$DateTime, Data$Sub_metering_1, type='l', ylab="Energy sub metering", xlab="");
  lines(Data$DateTime, Data$Sub_metering_2, type='l', col = 'red');
  lines(Data$DateTime, Data$Sub_metering_3, type='l', col='blue');
  legend('topright', legend=names(Data)[7:9], lty=1, col=c("black", "red", "blue"));
  plot(Data$DateTime, Data$Voltage, type='l', xlab='datetime')
  plot(Data$DateTime, Data$Global_reactive_power, type='l', xlab='datetime')
}

#Read Data
Data <- ReadData();

#Plot Data to make sure it looks good
GeneratePlot();

#Save it to a .png.  Normally would use dev.copy but using .png directly as per ta instructiont to avoid resizing issues
png(filename="plot4.png", width = 480, height = 480);
GeneratePlot();
dev.off();