# Working on automatically attaching purged direct to df

purge.lm <- function(x, direct, indirect){
  message("*** Consider attaching purged variable to your dataset, using the code: data.frame$purged <- purged")
  base <- lm(as.numeric(x[,direct]) ~ as.numeric(x[,indirect]))
  purged <- base$residuals
  x$purged <- purged
  #return(purged)
  return(x)
}

# This returns full data frame when calling "purge" command

# Then, store df as new; but same issue as returning only purged vector as before...

df <- purge.lm(x, "direct", "indirect")
