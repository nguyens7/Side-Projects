
# clear up workspace
rm(list=ls())
graphics.off()

# Load libraries
library(tidyverse)
library(broom)


# Set working directory
setwd("~/Library/Mobile\ Documents/com~apple~CloudDocs/R/MSU Consulting/Kenny")
# Read in data
data <- read_csv("Dummy_data.csv")

data

# Make data from wide to long
d1 <- data %>% 
  gather(key, values, 3:29) %>% 
  separate(key, into=c("biorep", "Pokemon", "Time"), sep="_")


d1


# Make multiple columns factors -------------------------------------------
d1 <- d1 %>% 
  mutate_at(vars(When:Time), as.factor) %>% # This code is the same as lines 32-36
  mutate_at(vars(values),as.numeric)

# d1$When <- as.factor(d1$When)
# d1$FA <- as.factor(d1$FA)
# d1$biorep <- as.factor(d1$biorep)
# d1$strain <- as.factor(d1$strain)
# d1$Time <- as.factor(d1$Time)

#to change a bunch of columns into factors

#data %>% 
  #mutate_at(vars(B:F), as.factor)


d2 <- d1 %>% 
  group_by(When, FA, Pokemon, Time) %>% 
  summarise( N = length(values),
             mean = mean(values),
             sd = sd(values),
             se = sd/sqrt(N))

cbbPalette <- c("grey20", "grey", "white")

d2 %>% 
  filter(When =="Day" & Pokemon =="Squirtle") %>% 
  ggplot (aes(x=FA, y=mean, fill=Time))+
  geom_col(colour="black", position=position_dodge())+
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.4, 
                size=0.8, colour="grey20", position=position_dodge(.9))+
  scale_fill_manual(values=cbbPalette)+
  scale_y_continuous(expand=c(0,0))+ #set bottom of graph
  ylab("Fake Units") + # Y axis label
  xlab("") + # X axis label
  ggtitle("Fake Squirtle_Day Data")


# Faceting d2 dataframe by Lipid ------------------------------------------

d2 %>% 
  ggplot (aes(x=FA, y=mean, fill=Time))+
  geom_col(colour="black", position=position_dodge())+
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.4, 
                size=0.8, colour="grey20", position=position_dodge(.9))+
  scale_fill_manual(values=cbbPalette)+
  scale_y_continuous(expand=c(0,0))+ #set bottom of graph
  ylab("Fake Units") + # Y axis label
  xlab("") + # X axis label
  ggtitle("Fake Pokemon Data")+
  facet_grid(When~Pokemon)

# Purrr -------------------------------------------------------------------

# The idea is to use the tidyr and purrr package to 'nest' your data
# You essentially will create a dataframe full of dataframes

model <- d1 %>% 
  group_by(When, FA, Pokemon) %>%     
  nest() %>%      # nest by Lipid, FA and strain 
  mutate(Shapiro = map(data, ~shapiro.test(.$values)),    # perform a normality test
           ANOVA = map(data, ~aov(values~Time, data = .)),  # calculate the ANOVA for time values
           Tukey = map(ANOVA, ~TukeyHSD(.)))                # calculate the TukeyHSD post hoc analysis


model$data[[1]] # Query the first row of the 'data' list-column which contains a nested dataframe
 

# To see if we nested the data correctly we can look at values that we think my be significant
# Such as PG, W3, 16:1 which corresponds to the 23rd entry in the 'model' dataframe

model$data[[23]] # Looking at time values for Squirtle, Day , 16:1 

model$Shapiro[[23]] # Shapiro

model$ANOVA[[23]] # ANOVA

model$Tukey[[23]] # Tukey


#  Extracting the data ----------------------------------------------------



# We can unnest the results from the Shapiro test
Shapiro_df <- model %>%
  unnest(map(Shapiro, tidy)) %>%
  rename(shapiro.statistic = statistic,  # rename the shapiro statistic
         shaprio.p.value = p.value) %>%  # rename the shaprio p value 
  filter(shaprio.p.value >.05)           # Filter on values >0.05, therefore normally distributed

# We can unnest the dataframe to get the ANOVA values 
ANOVA_df <- Shapiro_df %>%
  unnest(map(ANOVA, glance)) %>% 
  rename(ANOVA.statistic = statistic)

ANOVA_df

# We can unnest the dataframe to get the TukeyHSD values
TukeyHSD_df <- ANOVA_df %>%
  unnest(map(Tukey, tidy))

TukeyHSD_df


# Observe for significant differences with p < 0.05
Significant <- TukeyHSD_df %>% 
  filter(adj.p.value < 0.05) %>% 
  arrange(adj.p.value)

Significant

Significant %>% 
  select(When:Pokemon, term, comparison, adj.p.value) # Removing the other columns to get the comparisons that you care about



# Demo of nesting with mtcars dataset -------------------------------------
mtcars %>%
  nest(-cyl) %>%
  mutate(fit = map(data, ~lm(mpg ~ wt, data = .))) %>% 
  unnest(map(fit, glance))
