rm(list=ls())

library(tidyverse)
df <- read.csv("catalog.csv")

# celkový počet sesuvů půdy v jednotlivých letech
df$date <- mdy(df$date)
df$year <- year(df$date)
cetnost <- df %>% group_by(year) %>% summarise(celkovy_pocet_sesuvu = n())

# kumulativní suma
roky <- cetnost$year
kumulativni_soucet <- cumsum(cetnost$celkovy_pocet_sesuvu)
cumsum <- data.frame(roky, kumulativni_soucet)

# graf kumulativních součtů celkového počtu sesuvů dle let
cumsum %>% ggplot(aes(roky, kumulativni_soucet)) +
  geom_line() + labs(title="Graf kumulativních součtů")

# průměrný počet sesuvů půdy v jednotlivých měsících 
df$month <- month(df$date)
year <- df$year
month <- df$month
cetnost <- df %>% group_by(year, month) %>% count()
prumer <- cetnost %>% group_by(month) %>%
  summarise(prumer_sesuvu = mean(n))

# graf
prumer %>% ggplot(aes(month, prumer_sesuvu)) +
  geom_line() + 
  labs(title="Průměr počtu sesuvů v jednotlivých měsících",
       x="Měsíc",
       y="Průměrný počet sesuvů") +
  scale_x_continuous(breaks=1:12)         # číslování osy x

# to stejné, ale vybereme pouze country_name == "United States"
df_usa <- df %>% filter(str_detect("United States",country_name))
df_usa$month <- month(df_usa$date)
year <- df_usa$year
month <- df_usa$month
cetnost <- df_usa %>% group_by(year, month) %>% count()
prumer <- cetnost %>% group_by(month) %>%
  summarise(prumer_sesuvu = mean(n))
# graf
prumer %>% ggplot(aes(month, prumer_sesuvu)) +
  geom_line() + 
  labs(title="USA: Průměr počtu sesuvů v jednotlivých měsících",
       x="Měsíc",
       y="Průměrný počet sesuvů") +
  scale_x_continuous(breaks=1:12)

# Spočítejte průměrný počet sesuvů půdy za rok pro každý stát v tabulce.
year <-  df$year
country_name <- df$country_name
cetnosti <- df %>% group_by(year,country_name) %>% summarise(pocet_sesuvu=n())
prumery <- cetnosti %>% group_by(country_name) %>% summarise(prumer = mean(pocet_sesuvu))
serazene_prumery <- prumery %>% arrange(desc(prumer))
View(serazene_prumery)






