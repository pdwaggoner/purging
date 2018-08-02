#' Purges mediator effects between two independent variables (probit link function)
#'
#' Purges mediator effects between two independent variables, where selection (direct) variable is binary, and returns new "purged" direct variable to be used in multivariate specification.
#'@usage purge.probit(x, "direct", "indirect")
#'@param x Represents data frame, though usage requires the data.frame name
#'@param direct Represents "direct", or mediator variable, though usage requires column's name
#'@param indirect Represents "indirect", or mediated variable, though usage requires column's name
#'@details Purging of mediator effects between two independent variables in two steps. First, the function regresses the direct (mediator) variable on the indirect (mediated) variable. Second, it stores and uses the residuals from the bivariate specification as the new "purged" variable to be used in place of the original "direct" variable in multivariate analyses. Regarding syntax, the function is built with placeholder objects to calculate the quantities of interest. Then, the usage allows placing the real objects' names from working datasets (including, data frame, direct variable name in quotes, and indirect variable name in quotes) for intuitive usage.
#'@return purged
#'@examples
#' df <- data.frame(A = rep(0:1, 20), B = 2:21) # probit/binary example
#' purge.probit(df, "A", "B")
#'@export
purge.probit <- function(x, direct, indirect){
  message("*** Consider attaching purged variable to your dataset, using the code: data.frame$purged <- purged")
  base <- glm(as.numeric(x[,direct]) ~ as.numeric(x[,indirect]), family = binomial("probit"))
  purged <- base$residuals
  return(purged)
}
