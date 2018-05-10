library(rvest)
library(tidyverse)
library(tibble)
library(stringr)
library(lubridate)

lego_movie <- read_html("http://www.imdb.com/title/tt1490017/")

rating <- lego_movie %>% 
  html_nodes("strong span") %>%
  html_text() %>%
  as.numeric()
rating

wiki <- read_html("https://en.wikipedia.org/wiki/United_States_presidential_election")

election <- wiki %>% 
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[2]') %>% 
  html_table()
  
election_df <- election[[1]] %>% 
  as.tibble()

test <- election_df %>%
  select(-`Vice presidential candidate`,-Notes) %>%
  rename(Pres_cand = `Presidential candidate`,
         Pop_vote = `Popular vote`,
         Percent_vote = `%`) %>% 
  separate(`Electoral votes`, into =c("Electoral_votes","Electoral_total"), sep = " / ") %>% 
  mutate(Pop_vote = str_replace_all(Pop_vote, "[:alpha:]|[53]|[0]|[:punct:]" , "") %>% as.numeric()) %>% 
  drop_na() %>% 
  mutate_at(vars(Electoral_votes, Electoral_total),as.numeric) %>% 
  filter(Electoral_votes > 10) 
  

test$Year %>% make_year()

pres_url <- "https://en.wikipedia.org/wiki/United_States_presidential_election,_2016"
pres_df <- read_html(pres_url) %>% 
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/div[42]/table') %>% 
  html_table() %>% 
  .[[1]] %>% 
  dim()

SOTU <- read_html("http://www.thisnation.com/library/sotu/2009bo.html")

BO_2009 <- SOTU %>% 
  html_nodes(xpath = '//*[@id="feature"]') %>% 
  html_text() %>% 
  read_lines()


