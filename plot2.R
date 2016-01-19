##Step 1: Store location of data in URL
URL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

##Step 2: Check to see if local file exists called data, if not, create it and download the file from the URL
if(!file.exists("data"){
  dir.create("data")
}
download.file(URL, destfile="./data/electric.zip")

##Step 3: Unzip file to new folder electric in data folder
unzip("./data/electric.zip", exdir="./data/electric")

##Step 4: Load data
library(data.table)
data<-fread("./data/electric/household_power_consumption.txt",na.strings="?")

##Step 5: Subset data for just those values from February 1 and 2 2007
test<-subset(data,Date=="1/2/2007")
test2<-subset(data,Date=="2/2/2007")
dataset<-rbind(test,test2)

##Step 6: Plot 2
library(lubridate)
dataset<-within(dataset,DT<-paste(Date,Time))
dataset<-within(dataset,DT2<-dmy_hms(DT))
png(file="plot2.png")
with(dataset,plot(DT2,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)"))
dev.off()