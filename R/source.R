GAZ2 <- read.csv("https://raw.githubusercontent.com/qwerty29544/RpracticeBook/master/2Data/01FlatTables/GAZ.csv", 
                header = T, 
                sep = "\t", 
                encoding = "UTF-8", 
                dec = ",")
GAZ <- GAZ2
#View(GAZ2)
GAZ <- na.omit(GAZ)
  

GAZ$Туст..К = GAZ$Туст..С + 273
GAZ <- GAZ[, c(1,2,10,4:9)]
GAZ$ID <- as.factor(GAZ$ID)
GAZ$Куст <- as.factor(GAZ$Куст)
GAZ$Группа <- as.factor(GAZ$Группа)

GAZ$Газ_Конд <- GAZ$газ.м3.сут/GAZ$конд.т.м3.сут
GAZ$Газ_Вод <- GAZ$газ.м3.сут/GAZ$вода.м3.сут
GAZ$Вод_Конд <- GAZ$вода.м3.сут/GAZ$конд.т.м3.сут
View(GAZ)
GAZ2018 <- GAZ[format(as.Date(GAZ$дата.замера, "%d/%m/%Y" ), "%Y") == "2018",]
View(GAZ2018)
GAZ111 <- GAZ2018[GAZ2018$ID==111,]
View(GAZ111)

a <- unique(GAZ$ID)
b <- unique(GAZ[GAZ$вода.м3.сут > 2,]$ID)
c <- a[!a%in%b]
print(levels(c))

d <- unique(GAZ[GAZ$вода.м3.сут + GAZ$газ.м3.сут + GAZ$конд.т.м3.сут < 1000,]$ID)
e <- a[!a%in%d]
print(levels(e))


spl <- split(GAZ2018, GAZ2018$Группа)
#View(spl)
sums = c()
for(i in 1:length(spl))
  sums[i] <- sum(spl[[i]]$газ.м3.сут)
#sums

print(names(spl)[which.max(sums)])

spl2 <- split(GAZ2018, GAZ2018$Куст)
#View(spl2)
sums2 = c()
for(i in 1:length(spl2))
  sums2[i] <- sum(spl2[[i]]$вода.м3.сут)
#sums2

print(names(spl2)[which.max(sums2)])
