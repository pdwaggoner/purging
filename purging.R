# See the README markdown for an overview of the example here. 

# Read in the UN data in the attached data folder

# Start with simple bivariate specification
UN$Contracept <- as.numeric(as.character(UN$Cont)) # character to generate "NA" instead of ".."

labor.model <- lm(Fert ~ FemEc, data = UN); summary(labor.model)

# Now, we can add the other IV of interest to set up the need to purge
multi.model <- lm(Fert ~ FemEc + Contracept, data=UN); summary(multi.model)

# Each independently impacts Fert, but not together, suggesting mediation effects, which turns our original causal model to:  LABOR (indirect) -> CONTRACEPT (direct) -> FERTILITY
m1 <- lm(Contracept ~ FemEc, data = UN); summary(m1)

post <- UN[UN$Cont != "..", ] # create new dataset with only values (i.e., exclude "NAs")

post$purge <- m1$residuals # portion of "Contracept" independent of "FemEc"

m2 <- lm(Fert ~ FemEc + purge, data=post); summary(m2)

# Inspect the unique impacts picked up as a result of the purging strategy

pairs(~ GDP + FemEc + purge, data = post, pch=19)
