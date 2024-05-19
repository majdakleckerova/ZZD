rm(list=ls())
library(tidyverse)
data <- read.csv("StudentsPerformance.csv")

# vytvoření náhodných vzorků (=podmnožin o různých velikostech)
# velikosti_vzorku <- c(0,50,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800,850,900,950,1000)
velikosti_vzorku <- seq(0,1000,5)
sloupec <- data$math.score

# funkce
prumery_vzorku <- sapply(velikosti_vzorku, function(velikost_vzorku){
  vzorek <- sample(sloupec, velikost_vzorku)
  prumer <- mean(vzorek)
  return(prumer)
})

celkovy_prumer <- mean(sloupec)
vysledky <- abs(prumery_vzorku - celkovy_prumer)

df <- data.frame(velikosti_vzorku, vysledky)
df %>% ggplot(aes(x=velikosti_vzorku,y=vysledky, color="aquamarine")) +
  geom_line() +
  xlab("Počet vzorků") +
  ylab("Střední hodnota") +
  theme(legend.position= "none") 

# KORELACE A REGRESE
x <- data$math.score
y1 <- data$reading.score
y2 <- data$writing.score

# vztah math.score ~ reading.score
pearson_1 <- cor(x,y1)
spearman_1 <- cor(x,y1, method = "spearman")
# vztah math.score ~ writing.score
pearson_2 <- cor(x,y2)
spearman_2 <- cor(x,y2, method = "spearman")
# lineární regresní modely
model_1 <- lm(y1 ~ x)
model_2 <- lm(y2 ~ x)
# grafy
par(mfrow = c(1,2))                     # zobrazení obou grafů najednou na výšku

plot(x, y1, col="blueviolet",xlab="math.score", ylab="reading.score",
     main=paste0("Pearsonův koeficient = ",round(pearson_1,3),"\nSpearmanův koeficient = ",round(spearman_1, 3)))
abline(model_1, col="deeppink")         # osa

plot(x, y2, col="blueviolet",xlab="math.score", ylab="writing.score",
     main=paste0("Pearsonův koeficient = ",round(pearson_2,3),"\nSpearmanův koeficient = ",round(spearman_2, 3)))
abline(model_2, col="deeppink")         # osa




