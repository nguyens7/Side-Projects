library(hexSticker)

square <- "narrow-square.png"
imgurl <- "http://static1.squarespace.com/static/57bb3055bebafb7004912da4/t/57c044fcb8a79bb2afe0d280/1518042452165/?format=1500w"
sticker(square, package="", p_size=4, s_x=1, s_y=1.1, s_width=.75,s_height = 0.75,
        spotlight = TRUE, l_x=1, l_y = 1.30, l_height = 4,l_width = 4, l_alpha = 0.20,
        h_fill="#18453B", h_color="#97A2A2",
        filename="MSUDS3.png")


sticker(square, package="", p_size=4, s_x=1, s_y=1, s_width=.75,s_height = 0.75,
        spotlight = TRUE, l_x=1, l_y = 1.30, l_height = 4,l_width = 4, l_alpha = 0.20,
        h_fill="#18453B", h_color="#97A2A2",
        filename="MSUDS4.png")


library(tidyverse)
library(tidyNano)


file <- system.file("extdata", "beads.csv", package = "tidyNano")

tidy_data <- nanoimport(file) %>% 
  nanotidy(2:13) %>% 
  separate(Sample, into = c("Sample", "Dilution", "filter", "injection", "Tech_rep"),
           sep = "_", convert = TRUE) %>% 
  mutate_at(vars(Sample,filter:Tech_rep), as.factor) %>% 
  mutate(True_count = Dilution * Count)

tidy_data

Tech_avg_data <- tidy_data %>%
  nanolyze(particle_size, Sample, Dilution,filter, injection, 
           name = "Tech_rep",
           param_var = True_count)

Tech_avg_data

Injection_avg_data <- Tech_avg_data %>% 
  nanolyze(particle_size, Sample, Dilution, filter, 
           name = "Injection",
           param_var = Tech_rep_mean)

Injection_avg_data

p <- Injection_avg_data %>% 
  filter(
         particle_size < 600) %>% 
  ggplot(aes(x = particle_size, y = Injection_mean, color = filter)) +
  geom_line( size = .7, alpha = 0.8) + 
  guides(color = FALSE) + 
 theme_void()
p

sticker(p, package="tidyNano", p_size=7, p_x = 1.18, p_y = .85, 
        spotlight = TRUE, l_x=1.45, l_y = 1.45, l_height = 3,l_width = 3, l_alpha = 0.15,
        s_x=1, s_y=.95, s_width=1.8, s_height=1,
        h_fill="#323232", h_color="#ffffff",
        filename="tidyNano.png")

?sticker

##BF55EC  Purple
