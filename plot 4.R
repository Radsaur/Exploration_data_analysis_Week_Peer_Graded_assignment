
library(dplyr)
library(lubridate)

#import and preprocessing
df<- read.table('household_power_consumption.txt',sep=";", header = T)
str(df)
df1<-df
df1$date<- lubridate::dmy(df1$Date)

df11<- dplyr::filter(df1, date=='2007-02-01' | date=='2007-02-02')
df2<- dplyr::filter(df1, date=='2007-02-01' | date=='2007-02-02')
df2$Global_active_power<-as.character(df2$Global_active_power)
df2$Global_active_power<-as.numeric(df2$Global_active_power)

df2%>%dplyr::mutate(sub1=as.character(Sub_metering_1),
                    sub1=as.numeric(sub1),
                    sub2=as.character(Sub_metering_2),
                    sub2=as.numeric(sub2),
                    sub3=as.character(Sub_metering_3),
                    sub3=as.numeric(sub3))->df2

df2$Voltage<-as.character(df2$Voltage)
df2$Voltage<-as.numeric(df2$Voltage)

df2$Global_reactive_power<-as.character(df2$Global_reactive_power)
df2$Global_reactive_power<- as.numeric(df2$Global_reactive_power)



png(file='plot 4.png')
#Plot4
par(mfrow=c(2,2))
par(mar = c(2, 2, 2, 2))

#4.1
plot(df2$Global_active_power,type = "l",ylab= "Global Active Power (kilowatts)",
     xaxt = "n",xlab = "")
axis(1, at=c(0,1500,length(df2$Global_active_power)), labels=c("Thu", "Fri","Sat"))


#4.2
plot(df2$Voltage,type = 'l',ylab = "Voltage", xlab='datetime',xaxt = "n")
axis(1, at=c(0,1500,length(df2$Global_active_power)), labels=c("Thu", "Fri","Sat"))


#4.3
plot(df2$sub3,type = "l",ylim=range(0:40),col=4,ylab = "Energy sub metering",
     xaxt = "n")
axis(1, at=c(0,1500,length(df2$Global_active_power)), labels=c("Thu", "Fri","Sat"))
lines(df2$sub1)
lines(df2$sub2,col=2)
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c('black','red','blue'),lty=1,cex = 0.45, pt.cex = 1)

#4.4
plot(df2$Global_reactive_power,type = "l",xlab='datetime',
     ylab = "Global_reactive_power",xaxt="n")
axis(1, at=c(0,1500,length(df2$Global_active_power)), labels=c("Thu", "Fri","Sat"))

dev.off()

#Returning default values
par(mfrow=c(1,1))
par(mar = c(5.1, 4.1, 4.1, 2.1))

