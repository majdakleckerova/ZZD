rm(list=ls())
library(tidyverse)
df <- read.csv("StudentsPerformance.csv")

# Base Graphics
plot(df$writing.score,df$reading.score, main="Base Graphics", xlab="writing score",
     ylab="reading score", col="#FF3399")

# GGPLOT2
df %>% ggplot(aes(writing.score,reading.score, color="#FF3399")) + geom_point() +
  labs(title="ggplot2")

# * avg_score
df2 <- df %>% mutate("avg_score" = 
                       (writing.score + reading.score + math.score)/3)

# base graphics
hist(df2$avg_score, col="#FF3399", main="Rozdělení počtu bodů",
     xlab="Počet bodů", ylab = "Četnost")

# ggplot2
df2 %>%  ggplot(aes(avg_score, color="grey")) +
  geom_histogram(bins=10) +
  labs(title="Rozdělení počtu bodů") + 
  xlab("Počet bodů") +
  ylab("Četnost") + 
  theme(legend.position= "none")    # skrytí legendy pro barvy

# sloupcový graf pro četnosti záznamů
cetnosti <- df2 %>% group_by(race.ethnicity) %>%
  summarise(cetnost = n())
barplot(height=cetnosti$cetnost,names.arg = cetnosti$race.ethnicity, col="#FF3399")

# sloupcový graf rozdělený na pohlaví
cetnosti <- df2 %>% group_by(gender, race.ethnicity) %>%
  summarise(cetnost = n())

cetnosti %>% ggplot(aes(race.ethnicity, cetnost, fill= race.ethnicity)) +
  geom_col() + 
  facet_wrap(~gender) +
  labs(title="Kontrola vyváženosti statistického vzorku") +
  xlab("Etnicita") +
  ylab("Počet testovaných")

# koláčový graf z četností 
cetnosti %>% ggplot(aes(x="", y = cetnost, fill= race.ethnicity)) +
  geom_col() + 
  theme_minimal() +
  facet_wrap(~gender) +
  labs(title="Kontrola vyváženosti statistického vzorku", fill="Etnicita") +
  coord_polar("y")


