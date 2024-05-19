# ZZD
# CVIČENÍ 7
```{r}
rm(list=ls())                     # obnovení prostředí
library(tidyverse)                # načtení knihovny
df <- read.csv("shootings.csv")   # načtení csv souboru do proměnné "df"
```

## 1. V tabulce nalezněte 5 států, kde nejčastěji dochází ke střelbě při policejních zásazích.
```{r, execute = TRUE}
pocty_streleb <- df %>% 
  group_by(state) %>%               # rozdělení podle států
  summarise(pocet=n())              # výpočet četností jednotlivých států

serazeno <- pocty_streleb %>%                           
  arrange(desc(pocet))              # seřazení sestupně podle sloupce počet_střeleb
vysledek_1 <- head(serazeno, 5)     # zobrazení pouze prvních 5 položek
print(vysledek_1)
```

## 2. Pro každý z těchto států vytvořte sloupcový graf popisující počet zastřelených osob v jednotlivých letech.
```{r, execute = TRUE}
df$date <- ymd(df$date)
df$year <- year(df$date)

vysledek_2 <- df %>% 
  filter(state %in% vysledek_1$state) %>%     # filtrace pouze těch států z df, co se nachází v top_5
  group_by(state, year) %>%                   # rozdělení podle státu a roku
  count()                                     # výpočet

print(vysledek_2)

vysledek_2 %>% ggplot(aes(year, n, fill = n)) +
  geom_col() + 
  facet_wrap(~state)
```

## 3. Vypište 10 nejméně zastoupených hodnot zbraní z celého původního datasetu.
```{r, execute = TRUE}
pocet <- df %>% group_by(armed) %>% count()
serazeno <- pocet %>% arrange(n)
vysledek_3 <- head(serazeno, 10)
print(vysledek_3)
```

## 4. Do koláčového grafu vyneste četnost útočníků ozbrojených těmito zbraněmi:
```{r, execute = TRUE}
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
```
