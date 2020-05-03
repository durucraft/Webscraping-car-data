library(dplyr)
final_car<-read.csv('finale_car.csv', header=TRUE, sep=",",
                    na.strings= c( " ", ""))
Vehicle<-select(filter(final_car,Styles=="Wagon"& Price<25000 & 15000<Miles& Miles<=90000),c(Year,Miles,City,Highway,Turbo,DrivingType,Curbwieght_y,HP_y,RPM,Color_num,Bran_N,Brand,Price,Name,Location,Style,Engine,Color,DriveType,Extrior))
Vehicle$HP_y<-as.numeric(as.character(Vehicle$HP_y))
Vehicle<-na.omit(Vehicle)
unique(Vehicle$Brand)
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
set.seed(2)
load("Sedanrf.RData")
library(Metrics)
library(randomForest)
ind<-sample(2,
            nrow(Vehicle),
            replace = TRUE,
            prob = c(0.75,0.25))
training<- Vehicle[ind==1,]
testing<- Vehicle[ind==2,]
car_price<-predict(sedanrf,testing)
relative_error<-(car_price-testing$Price)/testing$Price
rel_eror<-relative_error^2
brand_id<-which(rel_eror %in% min(rel_eror))
over_id<-which(relative_error %in% min(relative_error))
under_id<-which(relative_error %in% max(relative_error))
test_set<-cbind(testing,car_price)
setsa<-select(filter(test_set),c(Year,Miles,City,Highway,Curbwieght_y,HP_y,RPM,Price,car_price,Name,Style,Engine,Extrior,DriveType))
head(setsa)
testing$Price[246]
hist(relative_error,col = "blue",main = "Sedan")
d<-density(relative_error)
plot(d,main = "Sedan")
polygon(d, col="red", border="blue")
mse(testing$Price,car_price)
rmse(testing$Price,car_price)
set.seed(2)
load("SUVrf.RData")
library(Metrics)
library(randomForest)
ind<-sample(2,
            nrow(Vehicle),
            replace = TRUE,
            prob = c(0.75,0.25))
training<- Vehicle[ind==1,]
testing<- Vehicle[ind==2,]
car_price<-predict(SUVrf,testing)
relative_error<-(car_price-testing$Price)/testing$Price
rel_eror<-relative_error^2
best_case<-min(rel_eror)
brand_id<-which(rel_eror %in% best_case)
suv_under<-min(relative_error)
suv_over<-max(relative_error)
under_id<-which(relative_error %in% min(relative_error))
over_id<-which(relative_error %in% max(relative_error))
testing$Price[under_id]
car_price[under_id]
test_set<-cbind(testing,car_price)
Chev_test<-select(filter(test_set,Brand=="CHEVROLET"),c(Year,Miles,City,Highway,Curbwieght_y,HP_y,RPM,Price,car_price,Name,Location,Style,Engine,Color,Extrior,DriveType))
hist(relative_error,main = "SUV",col = "blue")
d<-density(relative_error)
plot(d,main = "SUV")
polygon(d, col="red", border="blue")
mse(testing$Price,car_price)
rmse(testing$Price,car_price)
mean(ape(testing$Price,car_price))
cor(testing$Price,car_price)
bias(testing$Price,car_price)
mae(testing$Price,car_price)
mape(testing$Price,car_price)
set.seed(2)
load("Wagonrf.RData")
library(Metrics)
ind<-sample(2,
            nrow(Vehicle),
            replace = TRUE,
            prob = c(0.75,0.25))
training<- Vehicle[ind==1,]
testing<- Vehicle[ind==2,]
car_price<-predict(Wagonrf,testing)
relative_error<-(car_price-testing$Price)/testing$Price
rel_eror<-relative_error^2
best_case<-min(rel_eror)
brand_id<-which(rel_eror %in% best_case)
under_id<-which(relative_error %in% min(relative_error))
over_id<-which(relative_error %in% max(relative_error))
testing$Price[under_id]
car_price[under_id]
hist(relative_error,main = "Wagon",col = "blue")
d<-density(relative_error)
plot(d,main = "Wagon")
polygon(d, col="red", border="blue")
mse(testing$Price,car_price)
rmse(testing$Price,car_price)
mean(ape(testing$Price,car_price))
cor(testing$Price,car_price)
bias(testing$Price,car_price)
mae(testing$Price,car_price)
mape(testing$Price,car_price)
set.seed(2)
load("Hactrf.RData")
library(Metrics)
ind<-sample(2,
            nrow(Vehicle),
            replace = TRUE,
            prob = c(0.75,0.25))
training<- Vehicle[ind==1,]
testing<- Vehicle[ind==2,]
Hatc_veh$xlevels[["Bran_N"]]<-union(Hatc_veh$xlevels[["Bran_N"]], levels(testing$Bran_N))
car_price<-predict(Hatc_veh,testing)
relative_error<-(car_price-testing$Price)/testing$Price
rel_eror<-relative_error^2
best_case<-min(rel_eror)
brand_id<-which(rel_eror %in% best_case)
under_id<-which(relative_error %in% min(relative_error))
over_id<-which(relative_error %in% max(relative_error))
testing$Price[over_id]
car_price[over_id]
hist(relative_error,main = "Hatchback",col = "blue")
d<-density(relative_error)
plot(d,main = "Hatchback")
polygon(d, col="red", border="blue")
mse(testing$Price,car_price)
rmse(testing$Price,car_price)
mean(ape(testing$Price,car_price))
cor(testing$Price,car_price)
bias(testing$Price,car_price)
mae(testing$Price,car_price)
mape(testing$Price,car_price)
cor(testing$Price,car_price)
x=1
y=2
load()