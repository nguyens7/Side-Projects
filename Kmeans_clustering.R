library(tidyverse)
library(factoextra)
library(babynames)

# Babynames ---------------------------------------------------------------
babynames <- babynames

# Create matrix of top 5 female names
Females <- babynames %>% 
  filter(sex == "F") %>% 
  select(-sex,-prop) %>% 
  group_by(year) %>% 
  top_n(5, n) %>% 
  ungroup() %>% 
  spread(year,n, fill = 0) %>%
  remove_rownames() %>% 
  column_to_rownames(var = "name") %>% 
  as.matrix()

# K means
set.seed(123)
km_females <- kmeans(scale(Females), 8, nstart = 25) # 8 clusters, 25 random sets
km_females

# Make into data frame
Females_df <- Females %>% 
  as.data.frame() %>% 
  rownames_to_column(var = "name") %>% 
  mutate(group = as.factor(km_females$cluster))

# Plot 1990 vs 2010
Females_df %>%
  ggplot(aes(x =`1990` , y = `2010`, color = group)) +
  geom_point()+
  geom_text(aes(label = name),hjust=0, vjust=0)


# Visualize Clustering results
fviz_cluster(km_females, data = Females,
             ggtheme = theme_minimal(),
             main = "Clustering of Top 5 Female Names\n From 1880-2015")


