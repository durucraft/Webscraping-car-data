#install.packages("container")
library(container)
#install.packages("dplyr", verbose=T)
library(dplyr)
final_edit<-read.csv('finale_car.csv', header=TRUE, sep=",",
                     na.strings= c( " ", ""))
ref_df<-select(final_edit,c(DriveType,DrivingType,Color,Color_num,Brand,Bran_N))
ref_df$Brand<-(as.character(ref_df$Brand))
ref_df<-na.omit(ref_df)
#loads dict of colors to convert to different numbers
Colour<-function(Colour_type){
#   colour_dict<-Dict$new()
#   for(i in 1:length(ref_df$Color)){
#     key<-ref_df$Color[i]
#     value<-ref_df$Color_num[i]
#     if(match(ref_df$Color[i],ref_df$Color)==match(ref_df$Color_num[i],ref_df$Color_num)){
#       if(colour_dict$has(key)==TRUE){
#         i=i+1
#       }
#       else{
#         colour_dict$add(as.character(key),value)
#       }
#     }
#   }
# save(colour_dict,file="colour_dict.RDATA")
  load('colour_dict.RDATA')
  Colour_value<-getval(colour_dict,Colour_type)
  return(Colour_value)
}
#loads dict of drivetype to convert to different numbers
drivetype<-function(drive_type){
#   drivetype_dict<-Dict$new()
#   for(i in 1:length(ref_df$DriveType)){
#     key<-ref_df$DriveType[i]
#     value<-ref_df$DrivingType[i]
#     if(match(ref_df$DriveType[i],ref_df$DriveType)==match(ref_df$DrivingType[i],ref_df$DrivingType)){
#       if(drivetype_dict$has(key)==TRUE){
#         i=i+1
#       }
#       else{
#         drivetype_dict$add(as.character(key),value)
#       }
#     }
#   }
#   save(drivetype_dict,file="drivetype_dict.RDATA")
  load('drivetype_dict.RDATA')
  drivetype_value<-getval(drivetype_dict,drive_type)
  return(drivetype_value)
}
#loads dict of brand to convert to different numbers
Brand<-function(Brand_type){
  # brand_dict<-Dict$new()
  # for(i in 1:length(ref_df$Brand)){
  #   key<-ref_df$Brand[i]
  #   value<-ref_df$Bran_N[i]
  #   if(match(ref_df$Brand[i],ref_df$Brand)==match(ref_df$Bran_N[i],ref_df$Bran_N)){
  #     if(brand_dict$has(key)==TRUE){
  #       i=i+1
  #     }
  #     else{
  #       brand_dict$add(as.character(key),value)
  #     }
  #   }
  # }
  # save(brand_dict,file="brand_dict.RDATA")
  load('brand_dict.RDATA')
  Brand_value<-getval(brand_dict,Brand_type)
  return(Brand_value)
}

