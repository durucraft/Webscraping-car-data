#function that loads a dict of vaules that not in my regression model
car_brands<-function(my_style,veh_brand){
if (toString(my_style)=="Sedan"){
load("No_Sedan.RData")
check_brand<-unlist(not_brand)
tryCatch({
  if (which(check_brand %in% toString(veh_brand))){
    error_messages<-"Your car is not in dataset use to train model so your price would more likely be in correct."
  }
},error=function(err){
  error_messages<<-"Your car brand is in dataset."
}
)
}
  if (toString(my_style)=="SUV"){
    load("No_SUV.RData")
    check_brand<-unlist(not_brand)
    tryCatch({
      if (which(check_brand %in% toString(veh_brand))){
        error_messages<-"Your car is not in dataset use to train model so your price would more likely be in correct."
      }
    },error=function(err){
      error_messages<<-"Your car brand is in dataset."
    }
    )
  }
  if (toString(my_style)=="Wagon"){
    load("No_Wagon.RData")
    check_brand<-unlist(not_brand)
    tryCatch({
      if (which(check_brand %in% toString(veh_brand))){
        error_messages<-"Your car is not in dataset use to train model so your price would more likely be in correct."
      }
    },error=function(err){
      error_messages<<-"Your car brand is in dataset."
    }
    )
  }
  if (toString(my_style)=="Hatchback"){
    load("No_Hatchback.RData")
    check_brand<-unlist(not_brand)
    tryCatch({
      if (which(check_brand %in% toString(veh_brand))){
        error_messages<-"Your car is not in dataset use to train model so your price would more likely be in correct."
      }
    },error=function(err){
      error_messages<<-"Your car brand is in dataset."
    }
    )
  }
  return(error_messages)
}
