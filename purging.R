## Imports: MASS
## Working code/details in Roxygen syntax

#' Purges mediator effects between two independent variables
#'
#' Purges mediator effects between two independent variables, and returns new "purged" direct variable to be used in multivariate specification. Supports several functional forms (e.g., linear, logit, poisson, etc.).
#'@usage purge.lm(x, "direct", "indirect")
#'@usage purge.logit(x, "direct", "indirect")
#'@usage purge.probit(x, "direct", "indirect")
#'@usage purge.poisson(x, "direct", "indirect")
#'@usage purge.negbin(x, "direct", "indirect")
#'@param x Represents data frame, though usage requires the data.frame name
#'@param direct Represents "direct", or mediator variable, though usage requires column's name
#'@param indirect Represents "indirect", or mediated variable, though usage requires column's name
#'@details Purging of mediator effects between two independent variables in two steps. First, the function regresses the direct (mediator) variable on the indirect (mediated) variable. Second, it stores and uses the residuals from the bivariate specification as the new "purged" variable to be used in place of the original "direct" variable in multivariate analyses. Regarding syntax, the function is built with placeholder objects to calculate the quantities of interest. Then, the usage allows placing the real objects' names from working datasets (including, data frame, direct variable name in quotes, and indirect variable name in quotes) for intuitive usage.
#'@return purged
#'@examples
#' df <- data.frame(A = 1:10, B = 2:11) # linear/continuous example
#' purge.lm(df, "A", "B") # where, df = data frame; A = column name considered as "direct"; and B = column considered as "indirect"
#'
#' df <- data.frame(A = rep(0:1, 20), B = 1:20) # logit/binary example
#' purge.logit(df, "A", "B") # where, df = data frame; A = column name considered as "direct"; and B = column considered as "indirect"
#'
#' df <- data.frame(A = c(1,1,1,1,1,2,2,2,3,4), B = 1:10) # Poisson/counts example
#' purge.poisson(df, "A", "B")
#'@export
purge.lm <- function(x, direct, indirect){
  message("*** Consider attaching purged variable to your dataset, using the code: data.frame$purged <- purged")
  base <- lm(as.numeric(x[,direct]) ~ as.numeric(x[,indirect]))
  purged <- base$residuals
  return(purged)
}

purge.logit <- function(x, direct, indirect){
  message("*** Consider attaching purged variable to your dataset, using the code: data.frame$purged <- purged")
  base <- glm(as.numeric(x[,direct]) ~ as.numeric(x[,indirect]), family = binomial("logit"))
  purged <- base$residuals
  return(purged)
}

purge.probit <- function(x, direct, indirect){
  message("*** Consider attaching purged variable to your dataset, using the code: data.frame$purged <- purged")
  base <- glm(as.numeric(x[,direct]) ~ as.numeric(x[,indirect]), family = binomial("probit"))
  purged <- base$residuals
  return(purged)
}

purge.poisson <- function(x, direct, indirect){
  message("*** Consider attaching purged variable to your dataset, using the code: data.frame$purged <- purged")
  base <- glm(as.numeric(x[,direct]) ~ as.numeric(x[,indirect]), family=poisson)
  purged <- base$residuals
  return(purged)
}

purge.negbin <- function(x, direct, indirect){
  if (!requireNamespace("MASS", quietly = TRUE)) {
    stop("Package \"MASS\" needed for this function to work. Please install it.",
         call. = FALSE)
  }
  message("*** Consider attaching purged variable to your dataset, using the code: data.frame$purged <- purged")
  base <- MASS::glm.nb((as.numeric(x[,direct]) ~ as.numeric(x[,indirect])))
  purged <- base$residuals
  return(purged)
}
