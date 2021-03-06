library("sqldf") # In order to use sql to filter the data to import

f<-file("household_power_consumption.txt")

cons <- sqldf("select * from f where Date in ('1/2/2007','2/2/2007')",
              dbname = tempfile(), file.format = list(header = T, row.names = F, sep=";"))

cons$Time<-strptime(paste(cons$Date,cons$Time),"%d/%m/%Y %H:%M:%S")
cons$Date<-as.Date(cons$Date, "%d/%m/%Y")

rm(f)
png("plot2.png",480,480)
plot(cons$Time,cons$Global_active_power, type="l",xlab="", ylab="Global Active Power (kilowatts)")
dev.off()