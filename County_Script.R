#To Clear working environment
rm(list=ls())
graphics.off()


library(tidyverse)

ggplot2::map_data()


mi_counties <- map_data("county", "michigan") %>% select(lon = long, lat, group, id = subregion)

head(mi_counties)

#You can visualise vector boundary data with geom_polygon():
  ggplot(mi_counties, aes(lon, lat)) +
  geom_polygon(aes(group = group)) +
  coord_quickmap()

# Grey map  
ggplot(mi_counties, aes(lon, lat)) +
  geom_polygon(aes(group = group), fill = NA, colour = "grey50") + coord_quickmap()


tolower(dataframe$county)

#Create new county column
df2 <- df %>% 
  mutate(lower_county= county)

# dataframe$column_name 
df2$lower_county <- tolower(df2$lower_county)

left_join(mi_counties ,df2,by...)

#ggplot
state_counties <- map_data("county") %>% 
  filter(region %in% c("michigan","california","florida")) %>% 
  select(lon = long, lat, group, id = subregion)

ggplot(state_counties, aes(lon, lat)) +
  geom_polygon(aes(group = group)) +
  coord_quickmap()