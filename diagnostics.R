# The simplest diagnostic is to compare correlation coefficients pre and post purge, and then compare distrubtions. 
# See a simple example based on a recent R-Bloggers post (https://www.r-bloggers.com/introducing-purging-an-r-package-for-addressing-mediation-effects/)

library(MASS)
#install.packages("purging")
library(purging)

n = 5000
rho = 0.9

d = mvrnorm(n = n, mu = c(0, 0), 
            Sigma = matrix(c(1, rho, rho, 1), 
                           nrow = 2), 
            empirical = TRUE)

X = d[, 1]
Y = d[, 2]

d = data.frame(X, Y)

# Verify rho = 0.90
cor(d$X, d$Y)
plot(d$X, d$Y) # see correlation visually

# Call purge.lm to purge Y of X
purge.lm(d, "Y", "X")

# Attach to df for plot below
d$purged = purge.lm(d, "Y", "X") # Store as its own object 
  
# Check rho and plot again; see purged effects gone
cor(d$X, d$purged) 
plot(d$X, d$purged) 
