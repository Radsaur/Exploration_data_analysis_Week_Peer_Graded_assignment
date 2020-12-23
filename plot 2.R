#setting wd
x <- readline()
D:\DOCS\Sauran.S\R\Coursera\Course 4
x<-gsub("\\\\", "/", x)
setwd(x)


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


#Plot2
png(file = 'plot 2.png')
plot(df2$Global_active_power,type = "l",ylab= "Global Active Power (kilowatts)",
     xaxt = "n",xlab = "")
axis(1, at=c(0,1500,length(df2$Global_active_power)), labels=c("Thu", "Fri","Sat"))
dev.off()