rm(list = ls())

# použité knihovny
library(dplyr)
library(rvest)

# načtení tabulky z url
html <- read_html(url("https://ki.ujep.cz/cs/historie/"))
df <- html_table(html, header = TRUE)[[2]]

# nahrazení položek "Dosud" hodnotou 2024
df$Do[df$Do=="Dosud"] <- 2024

# převod na číselný datový typ
df$Do <- as.integer(df$Do)
df$Od <- as.integer(df$Od)

# vytvoření sloupce "Celkem_let", sestupné seřazení
df %>% mutate("Celkem_let" = (Do - Od)) %>% 
  arrange(desc(Celkem_let)) %>% View()

# načtení csv souboru (dát soubor do stejné složky jako R Script,
# Session -> Set Working Directory -> To Source File Location)

library(tidyverse)
df2 <- read.csv("StudentsPerformance.csv")

# * sloupce "avg_score"
df3 <- df2 %>% 
  mutate("avg_score" = ((math.score + reading.score + writing.score))/3)

# filtrace záznamů, co obsahují v parental.level.of.education "high school"
filtrovany_df <- df3 %>%
  filter(str_detect(parental.level.of.education, "high school"))

# průměrná hodnota avg_score pro kombinace gender, ethnicity
df4 <- df3 %>% group_by(gender, race.ethnicity) %>%
  summarise(prumer = mean(avg_score))

# úprava do širokého formátu
siroky_format <- pivot_wider(df4, names_from = "gender", values_from = "prumer")
View(siroky_format)



