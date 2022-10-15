setwd("~/Desktop")
pupae<-read.table('pupae.csv',header = T,sep = ",")
pupae$Gender<-as.factor(pupae$Gender)
pupae$CO2_treatment <- as.factor(pupae$CO2_treatment)

t.test(Frass ~ Gender, data=pupae)
palette(c("blue","red"))
with(pupae, plot(PupalWeight, Frass, pch=19, col=Gender))
legend("topleft", levels(pupae$Gender), col=palette(), pch=19)
fit <- lm(Frass ~ Gender * PupalWeight,data=pupae)
anova(fit)
pdata <- with(pupae, 
              expand.grid(Gender = levels(Gender), PupalWeight = mean(PupalWeight)))         
predict(fit, newdata = pdata, se = TRUE) 

library(lsmeans)
lsmeans(fit, "Gender")

install.packages('devtools')


update.packages()
