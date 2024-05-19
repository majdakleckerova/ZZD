# Cvičení 1
rm(list = ls())

# Určete hodnoty následujících výrazů pro hodnoty x=2 a x=4.
# Je-li to vhodné, zaokrouhlete výsledky na tři desetinná čísla.

x_1 <- 2
x_2 <- 4

vyraz_1 <- round(sqrt(cos(x_1 + (3 * pi / 2))), 3)
vyraz_1_b <- round(complex(real = sqrt(cos(x_2 + (3 * pi / 2)))), 3)

vyraz_2 <- round(log(2 * x_1**2 + 10) / log(4), 3)
vyraz_2_b <- round(log(2 * x_2**2 + 10) / log(4), 3)

print(vyraz_1)
print(vyraz_1_b)
print(vyraz_2)
print(vyraz_2_b)

# Pomocí funkcí pro práci s řetězci opravte chyby v textu. Text musí začínat velkým písmenem. 
# Jméno Zlatovláska má začínat velkým písmenem, jinak mají být všechna písmena malá.

text <- "copak zlaTOvláska ale JMELí!"
text <- tolower(text)
substring(text,1,1) <- toupper(substring(text,1,1))
text <- gsub("zlatovláska","Zlatovláska", text)
print(text)


# Práce s vektory
## skalární součin
pole1 <- c(1, 2, 3)
pole2 <- c(3, 4, 5)
skalarni_soucin <- sum(pole1 * pole2)
print(skalarni_soucin)
## vzdálenost
vzdalenost <- sqrt((pole1[1] - pole2[1])**2 + (pole1[2] - pole2[2]) **2 + (pole1[3] - pole2[3])**2)
print(vzdalenost)

v <- seq(-1,1,0.2)
print(v)



