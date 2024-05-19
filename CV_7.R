rm(list=ls())
library(tidyverse)
df <- read.csv("shootings.csv")

# V tabulce nalezněte 5 států, kde nejčastěji dochází ke střelbě při policejních zásazích.
pocty_streleb <- df %>% 
  group_by(state) %>%                                   # rozdělení podle států
  summarise(pocet=n())                                  # výpočet četností jednotlivých států

serazeno <- pocty_streleb %>%                           
  arrange(desc(pocet))                                  # seřazení sestupně podle sloupce počet_střeleb
vysledek_1 <- head(serazeno, 5)                              # zobrazení pouze prvních 5 položek

# Pro každý z těchto států vytvořte sloupcový graf popisující počet zastřelených osob v jednotlivých letech.
df$date <- ymd(df$date)
df$year <- year(df$date)

vysledek_2 <- df %>% 
  filter(state %in% vysledek_1$state) %>%                     # filtrace pouze těch států z df, co se nachází v top_5
  group_by(state, year) %>%                              # rozdělení podle státu a roku
  count()                                                # výpočet

vysledek_2 %>% ggplot(aes(year, n, fill = n)) + geom_col() + facet_wrap(~state)

# Vypište 10 nejméně zastoupených hodnot zbraní z celého původního datasetu.
pocet <- df %>% group_by(armed) %>% count()
serazeno <- pocet %>% arrange(n)
vysledek_3 <- head(serazeno, 10)

# Do koláčového grafu vyneste četnost útočníků ozbrojených těmito zbraněmi:
zbrane <- c("toy weapon", "ax", "crossbow","machete","gun")
cetnost <- df %>% filter(armed %in% zbrane) %>% group_by(armed) %>% count()

cetnost %>% ggplot(aes(x="", y=n, fill=armed)) +
  geom_col(width=1) + 
  coord_polar("y") +
  theme_minimal() + 
  theme(axis.text.x = element_blank(), # Odstranění textu osy x
        axis.ticks = element_blank(),  # Odstranění značek osy
        panel.grid = element_blank(),  # Odstranění mřížky
        axis.title = element_blank())  # Odstranění názvů os