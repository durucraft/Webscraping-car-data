
Analysis<-function(a_df){
  final_car<-read.csv('finale_car.csv', header=TRUE, sep=",",
                     na.strings= c( " ", ""))
  #install.packages("dplyr", verbose=T)
  library(dplyr)
  #getting the style of vehicles
  my.Vech<-a_df$Style
  #put criteria for price
  if (my.Vech=="SUV"){
    Car.price<-40000
  }else {
    Car.price<-25000
  }
  #filter dataset for attributes need to build model
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
  #calling dicts to convert input to number
  source("dicts.R")
  if(a_df$Turbo=="Turbo"){
    a_dfs<-0
  }else if(a_df$Turbo=="None"){
    a_dfs<-1
  }else{
    a_dfs<-2
  }
  Vechile_df <- data.frame(Year=as.integer(as.character(a_df$Year)),
                           Miles=as.integer(as.character(a_df$Miles)),
                           City=as.integer(as.character(a_df$City)),
                           Highway=as.integer(as.character(a_df$Highway)),
                           Turbo=as.factor(as.character(a_dfs)),
                           DrivingType=as.factor(as.character(drivetype(a_df$Drivetype))),
                           Curbwieght_y=as.integer(as.character(a_df$Curbwieght)),
                           HP_y=as.integer(as.character(a_df$HP)),
                           RPM=as.integer(as.character(a_df$RPM)),
                           Color_num=as.factor(as.character(Colour(a_df$Color))),
                           Bran_N=as.factor(as.character(Brand(toupper(a_df$Brand)))),
                           Price=as.integer(1200)
                           
  )
  set.seed(2)
  #install.packages('randomForest')
  library(randomForest)
   ind<-sample(2,
               nrow(Vehicle),
               replace = TRUE,
               prob = c(0.75,0.25))
   training<- Vehicle[ind==1,]
   testing<- Vehicle[ind==2,]
  # Sedanrf<-randomForest(Price~., data= training,mtry=8,ntree=301,importance=TRUE )
   # Hatc_veh<-lm(Price~Year+Miles+City+Highway+Turbo+DrivingType+Bran_N+HP_y,training)
   # Hatc_veh$xlevels[["Bran_N"]]<-union(Hatc_veh$xlevels[["Bran_N"]], levels(Vehicle_df$Bran_N))
   # save(Hatc_veh,file="HactRF.RData")
  #need to be able to predict prices cause does not have same id 
  Vechile_df<-rbind(training[1,],Vechile_df)
  Vehicle_df<-Vechile_df[-1,]
  #calling each regression model and predicitng price
  if (my.Vech=="Sedan"){
      load("Sedanrf.RData")
      rf_pred<-predict(sedanrf,Vechile_df[,-12])
      pred_list<-list(sedanrf,rf_pred[2])}
      else if (my.Vech=="SUV"){
      load("SUVrf.RData")
      rf_pred<-predict(SUVrf,Vechile_df[,-12])
      pred_list<-list(SUVrf,rf_pred[2])
     }else if (my.Vech=="Wagon"){
       load("WagonRF.RData")
       rf_pred<-predict(Wagonrf,Vechile_df[,-12])
       pred_list<-list(Wagonrf,rf_pred[2])
       }else{
       load("HactRF.RData")
         Hatc_veh$xlevels[["Bran_N"]]<-union(Hatc_veh$xlevels[["Bran_N"]], levels(Vehicle_df$Bran_N))
       hatc_pred<-predict(Hatc_veh,Vechile_df[,-12])
       pred_list<-list(Hatc_veh,hatc_pred[2])
     }
  return(pred_list)
}