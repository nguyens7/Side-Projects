library(tidyverse)
library(factoextra)
library(babynames)
library(ggfortify)
library(cowplot)
library(ggrepel)

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

# Compare Jennifer to Mary
interesting <- c("Jennifer", "Mary","Helen","Sophia")

babynames %>%
  filter(sex == "F" &
         name %in% interesting ) %>% 
  ggplot(aes(x = year, y = n, color = name)) +
  geom_line()


names(km_females$cluster[km_females$cluster==8])


# Wisconsin Cancer Study --------------------------------------------------

data <- "https://assets.datacamp.com/production/course_1815/datasets/WisconsinCancer.csv"
cancer <- read_csv(data)

cancer_matrix <- cancer %>% 
  select(-X33, -diagnosis, -contains("_se"), -contains("_worst")) %>% 
  remove_rownames() %>% 
  column_to_rownames(var = "id") %>% 
  as.matrix()

cancer_PCA <- prcomp(cancer_matrix, scale = TRUE)

cancer_PCA_df <- as.data.frame(cancer_PCA$rotation)
cancer_PCA_df$id <- row.names(cancer_PCA_df)

cancer_PCA_df

cancer_PCA_df

cancer_PCA_df %>% 
  ggplot(aes(x=PC1, y=PC2, label=id, color=id )) +
  geom_point() +
  geom_text_repel(size = 6)


fviz_eig(cancer_PCA)

fviz_pca_ind(cancer_PCA,
             col.ind = "contrib", # Color by the quality of representation,
             geom.ind = c("point"),  # "text"
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = FALSE )     # Avoid text overlapping

fviz_pca_var(cancer_PCA,
             col.var = "contrib", # Color by contributions to the PC
             geom.ind = c("point"),  # "text"
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE)     # Avoid text overlapping


fviz_pca_biplot(cancer_PCA, repel = TRUE,
                col.var = "#2E9FDF", # Variables color
                geom.ind = c("point"),  # "text"
                col.ind = "#696969")  # Individuals color



#  USArrests --------------------------------------------------------------


USArrests
 
