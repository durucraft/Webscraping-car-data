data_frames<-function(a_df){
  final_car<-read.csv('finale_car.csv', header=TRUE, sep=",",
                      na.strings= c( " ", ""))
  #install.packages("dplyr", verbose=T)
  library(dplyr)
  my.Vech<-a_df$Style
  if (my.Vech=="SUV"){
    Car.price<-40000
  }else{
    Car.price<-25000
  }
  Vehicle<-select(filter(final_car,Styles==toString(my.Vech)& Price<Car.price & 15000<Miles& Miles<=90000),c(Year,Miles,City,Highway,Turbo,DrivingType,Curbwieght_y,HP_y,RPM,Color_num,Bran_N,Price))
  Vehicle$HP_y<-as.numeric(as.character(Vehicle$HP_y))
  Vehicle<-na.omit(Vehicle)
  Vehicle<-transform(
    Vehicle,
    Year=as.integer(Year),
    Miles=as.integer(Miles),
    City=as.integer(City),
    Highway=as.integer(Highway),
    Turbo=as.factor(Turbo),
    DrivingType=as.factor(DrivingType),
    Curbwieght_y=as.integer(Curbwieght_y),
    HP_y=as.integer(HP_y),
    RPM=as.integer(RPM),
    Color_num=as.factor(Color_num),
    Bran_N=as.factor(Bran_N),
    Price=as.integer(Price)
  )
  return(Vehicle)
}
