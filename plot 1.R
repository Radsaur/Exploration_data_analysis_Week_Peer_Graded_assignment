#setting wd
x <- readline()
D:\DOCS\Sauran.S\R\Segmentation\Segment 2 portfolios\General PREPROCESSING SEGMENT
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

#PLOT 1
png(file="plot 1.png")
hist(df2$Global_active_power, col=2, xlab= "Global Active Power (kilowatts)",
     main="Global Active Power", ylim=range(0:1200))
dev.off()

