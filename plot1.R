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
  raw$Date <- as.Date(raw$Date, "%d/%m/%Y");
  raw$Time <- as.POSIXct(strptime(raw$Time, "%H:%M:%S"));
  
  return(raw[which(raw$Date >= as.Date('2007-02-01') & raw$Date <= as.Date('2007-02-02')), ]);
}

GeneratePlot <- function()
{
  hist(Data$Global_active_power, main = "Global Active Power", col='red', xlab="Global Active Power (kilowatts)");
}

#Read Data
Data <- ReadData();

#Plot it to see if it looks good
GeneratePlot();

#Save it to a .png.  Normally would use dev.copy but using .png directly as per ta instructiont to avoid resizing issues
png(filename="plot1.png", width = 480, height = 480);
GeneratePlot()
dev.off();