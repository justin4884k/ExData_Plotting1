#Download the file and unzip
fle <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- "Data.zip"
download.file(fle,file,method = "auto")
unzip(file)
#Read the dataset
elec <- read.table("household_power_consumption.txt",skip = 1,sep=";")
#Change the column names
names(elec) <- c("Date","Time","G_Active_Power","G_Reactive_Power","Volt","G_intensity","Sub_metering1","Sub_metering2","Sub_metering3")
#Create a subset with the chosen dates
subelec <- subset(elec,elec$Date=="1/2/2007"|elec$Date=="2/2/2007")
#Format the Date and time
subelec$Date <- as.Date(subelec$Date,format="%d/%m/%Y")
subelec$Time <- strptime(subelec$Time,format = "%H:%M:%S")
subelec[1:1440,"Time"] <- format(subelec[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subelec[1441:2880,"Time"] <- format(subelec[1441:2880,"Time"],"2007-02-02 %H:%M:%S")
#Create the plot
par(mfrow=c(2,2))
with(subelec,{
  plot(subelec$Time,as.numeric(as.character(subelec$G_Active_Power)),type = "l",xlab = "",ylab = "Global Active Power")
  plot(subelec$Time,as.numeric(as.character(subelec$Volt)),type = "l",xlab = "datetime",ylab = "Voltage")
  plot(subelec$Time,subelec$Sub_metering1,type = "n",xlab = "",ylab = "Energy Sub metering")
  with(subelec,lines(Time,as.numeric(as.character(Sub_metering1))))
  with(subelec,lines(Time,as.numeric(as.character(Sub_metering2)),col="red"))
  with(subelec,lines(Time,as.numeric(as.character(Sub_metering3)),col="green"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering1","Sub_metering2","Sub_metering3"),cex = 0.6)
  plot(subelec$Time,as.numeric(as.character(subelec$G_Reactive_Power)),type = "l",xlab = "datetime",ylab = "Global Reactive Power")
})