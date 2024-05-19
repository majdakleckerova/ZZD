rm(list = ls())
library(dplyr)

# zjištění počtu řádků a sloupců tabulky
pocet_radku <- nrow(iris)
pocet_sloupcu <- ncol(iris)
print(pocet_radku)
print(pocet_sloupcu)

# průměr
prumer <- mean(iris$Sepal.Length)
# směrodatná odchylka
odchylka <- sd(iris$Sepal.Length)

print(prumer)
print(odchylka)

# počet unikátních hodnot
pocet_unikatu_Species <- n_distinct(iris$Species)
print(pocet_unikatu_Species)

# četnost jednotlivých kategorií
cetnost <- iris %>% group_by(Species) %>% summarise(cetnost = n())
print(cetnost)

