# See the README markdown for an overview of the example here. 

# Read in the UN.csv data

# Start with simple bivariate specification
UN$Contracept <- as.numeric(as.character(UN$Cont)) # character to generate "NA" instead of ".."

lm1 <- lm(Fert ~ FemEc, data = UN); summary(lm1)

# Now, we can add the other IV of interest to set up the need to purge
lm2 <- lm(Fert ~ FemEc + Contracept, data=UN); summary(lm2)

# Each independently impacts Fert, but not together, suggesting mediation effects, which turns our original causal model to:  LABOR (indirect) -> CONTRACEPT (direct) -> FERTILITY
m1 <- lm(Contracept ~ FemEc, data = UN); summary(m1)

new.UN <- UN[UN$Cont != "..", ] # create new dataset excluding "NAs"

new.UN$purged <- m1$residuals # create "purged" variable, which is the portion of "Contracept" independent of "FemEc"

# Now update the multivariate specification with the purged variable, and inspect the differences in magnitude and significance compared to lm2 
m2 <- lm(Fert ~ FemEc + purged, data=new.UN); summary(m2)

# Inspect the unique impacts picked up as a result of the purging strategy
pairs(~ GDP + FemEc + purged, data = new.UN, pch=19)
