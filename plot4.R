library("sqldf") # In order to use sql to filter the data to import

f<-file("household_power_consumption.txt")

cons <- sqldf("select * from f where Date in ('1/2/2007','2/2/2007')",
              dbname = tempfile(), file.format = list(header = T, row.names = F, sep=";"))

cons$Time<-strptime(paste(cons$Date,cons$Time),"%d/%m/%Y %H:%M:%S")
cons$Date<-as.Date(cons$Date, "%d/%m/%Y")

rm(f)

png("plot4.png",480,480)
par(mfrow=c(2,2))
plot(cons$Time,cons$Global_active_power, type="l",xlab="", ylab="Global Active Power (kilowatts)")
plot(cons$Time,cons$Voltage, type="l",xlab="datetime", ylab="Voltage")

plot(cons$Time,cons$Sub_metering_1, type="l",ann="FALSE")
lines(cons$Time,cons$Sub_metering_2, type="l", col="RED")
lines(cons$Time,cons$Sub_metering_3, type="l", col="BLUE")
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1),col=c("black","red","blue"), cex=0.7, pt.cex = 0.5, bty="n")
title(ylab="Energy sub metering")
plot(cons$Time,cons$Global_reactive_power, type="l",xlab="datetime", ylab="Global_reactive_power")

dev.off()