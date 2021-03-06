% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/purge.poisson.R
\name{purge.poisson}
\alias{purge.poisson}
\title{Purges mediator effects between two independent variables (Poisson)}
\usage{
purge.poisson(x, "direct", "indirect")
}
\arguments{
\item{x}{Represents data frame, though usage requires the data.frame name}

\item{direct}{Represents "direct", or mediator variable, though usage requires column's name}

\item{indirect}{Represents "indirect", or mediated variable, though usage requires column's name}
}
\value{
purged
}
\description{
Purges mediator effects between two independent variables, where selection (direct) variable is an event count, and returns new "purged" direct variable to be used in multivariate specification.
}
\details{
Purging of mediator effects between two independent variables in two steps. First, the function regresses the direct (mediator) variable on the indirect (mediated) variable. Second, it stores and uses the residuals from the bivariate specification as the new "purged" variable to be used in place of the original "direct" variable in multivariate analyses. Regarding syntax, the function is built with placeholder objects to calculate the quantities of interest. Then, the usage allows placing the real objects' names from working datasets (including, data frame, direct variable name in quotes, and indirect variable name in quotes) for intuitive usage.
}
\examples{
df <- data.frame(A = c(1,1,1,1,1,2,2,2,3,4), B = 1:10) # Poisson/counts example
purge.poisson(df, "A", "B")
}
