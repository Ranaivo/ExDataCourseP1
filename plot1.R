library("sqldf") # In order to use sql to filter the data to import

f<-file("household_power_consumption.txt")

cons <- sqldf("select * from f where Date in ('1/2/2007','2/2/2007')",
              dbname = tempfile(), file.format = list(header = T, row.names = F, sep=";"))

cons$Time<-strptime(paste(cons$Date,cons$Time),"%d/%m/%Y %H:%M:%S")
cons$Date<-as.Date(cons$Date, "%d/%m/%Y")

rm(f)
par("mar"=c(5.1,5.1,4.1,2.1))
hist(cons$Global_active_power, main="Global Active Power", 
     xlab="Global active power (kilowatts)", col="RED", ylim=c(0,1200))
par("mar")

