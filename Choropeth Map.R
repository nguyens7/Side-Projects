#To Clear working environment
rm(list=ls())
graphics.off()

#load tidyverse
library(tidyverse)
library(maps)
library(ggmap)
library(mapdata)
library(RColorBrewer)

#set working directory
setwd("~/Desktop")
getwd()

#name csv file as my data
my_data <- "chris.csv"

#read csv and name it data
data <- read_csv(my_data)

data1 <- data%>%
  select(`Product Name`,PropertyState,DateOrdered,TurnTime)

data2 <- data1%>%
  separate(DateOrdered, into=c("Month","Day","Year", sep = "/"))%>% #Extract the month, day and year from the DateOrdered column
  select(-`/`)%>% #Include the Product.Name-Year columns
  rename(State = PropertyState) # rename ("new name that you want" = "oroginal name")

#FILTERING DATA
data2%>%
  filter(State == "MI"|State == "CA"| State == "FL") #note the `|` not `,`  # `,` = `and` criteria, `|` = `or`

data2%>%
  filter(State %in%  c("MI","CA","FL")) #to select multiple criteria


turntime <- data2%>%
  group_by(State)%>%
  arrange(desc(TurnTime))%>%
  arrange(State)

avgTT <- turntime%>%
  summarise(avg = mean(TurnTime))


usa <- map_data("usa")
states <- map_data("state")
ggplot(data = states) + 
  geom_polygon(aes(x = long, y = lat, fill = region, group = group), color = "white") + 
  coord_fixed(1.3) +
  guides(fill=FALSE)

crimes <- data.frame(state = tolower(rownames(USArrests)),USArrests)


USArrests

test <- data.frame(state.abb,tolower(state.name))

test <- test%>%
  rename(State=state.abb,state.name=tolower.state.name.)

test$State <- as.character(test$State)
test$state.name <- as.character(test$state.name)
  
joined <- inner_join(avgTT,test, by="State")

final <- right_join(joined,states, by = c("state.name"= "region"))

turntime <- ggplot(data = final) + 
  geom_polygon(aes(x = long, y = lat, fill = avg, group = group), color = "white") + 
  coord_fixed(1.3)+
  scale_fill_distiller(palette = "Spectral")+
  ggtitle("Average TurnTime")

png("~/Desktop/TurnTimeUS.png", width = 7, height = 5, units = 'in', res = 600)
turntime
dev.off()
