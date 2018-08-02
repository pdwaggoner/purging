# `purging` An R package for addressing mediation effects among independent variables
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/purging)](http://cran.r-project.org/package=purging)
[![total](http://cranlogs.r-pkg.org/badges/grand-total/purging)](http://cranlogs.r-pkg.org/)

## Why should I use `purging`?

Though there are some great packages for mediation analysis out there, the simple intuition of its need is often ambiguous, especially for younger graduate students. Thus, this set of files provides a quick, intuitive overview of mediation and offers a simple method for "purging" variables for use in multivariate analysis. The result of these files is an R package I recently released on [CRAN](https://CRAN.R-project.org/package=purging). See the `purging.R` file for the script across several functional forms as well as the `purging example.R` script for an applied example usingreal data (see examples below).

Suppose we are interested in whether committee membership relating to a specific issue domain influences the likelihood of sponsoring related issue-specific legislation. However, in the American context as representational responsibilities permeate legislative behavior, district characteristics in similar employment-related industries likely influence self-selection onto the issue-specific committees in the first place, which we also suggest should influence likelihood of related-issue bill sponsorship. Therefore, in this context, we have a mediation model, where employment/industry (_indirect_) -> committee membership (_direct_) -> sponsorship. Thus, we would want to purge committee membership of the effects of employment/industry in the district to observe the "pure" effect of committee membership on the likelihood of related sponsorship. 

Or consider another example in a different realm. Let's say we had a model where women's level of labor force participation determines their level of contraceptive use, and that the effect of female labor force participation on fertility is indirect, essentially filtered through its impact on contraceptive use. Once we control for contraceptive use, the direct effect of labor force participation (seen in the simple bivariate model, _lm1_, in the example code, `purging example.R`) goes away. In other words, the effect of labor force participation on fertility is likely indirect, and filtered through contraceptive use, which means the variables are also highly correlated. Many thanks to Scott Basinger and Patrick Shea (University of Houston) for the base of this second example here and the UN data from their graduate stats labs, which gave me the idea of expanding this out to develop an R package dedicated to addressing this issue.

These two examples offer simple ways of thinking about mediation effects (e.g., labor force (_indirect_) -> contraception (_direct_) -> fertility). If we run into this problem, a simple solution is "purging". The steps in this simple method are to, first, regress the _direct_ variable (in this case, "contraceptive use") on the _indirect_ variable (in this case, "labor force participation"). Then, store those residuals, which is the _direct_ effect of contraception after accounting for the _indirect_ effect of labor force participation. Then, we add the stored residuals as their own "purged variable" in the updated specification. Essentially, this purging process allows for a new _direct_ variable that is uncorrelated with the _indirect_ variable. When we do this, we will see that each variable is explaining unique variance in the DV of interest (you can double check this several ways, such as comparing correlation coefficients or by comparing R^2 across specifications). See the code file, `purging.R` for the example using real data from the United Nations Human Development Programme.

The `UN.csv` file is a small dataset based on the 2005 United Nations Human Development Programme report, with all data from 2003. Variables include: Human Development Index (HDI: combining female life expectancy at birth (Life), educational attainment, and income per capita); fertility rate (Fert: births per adult female); percentage of women using contraception (Cont); tech adoption as share of the population using cell phones (Cell: subscribers per 1000 people) and the share of the population using the internet (Inter: subscribers per 1000 people); per capita gross domestic product (GDP) in US dollars; carbon dioxide emissions per capita (CO2) measured in metric tons; female adult literacy rate (Liter); and finally adult women in the labor force per 100 men (FemEc).

Feel free to [reach out](http://www.philipdwaggoner.com/) if anything is unclear or if you want to chat more about mediation models/analysis, causal inference, etc. Once the intuition is mastered, check out some great work on mediation from many folks, including Kosuke Imai (Princeton), Luke Keele (Georgetown), and several others. See Imai's mediation site as a sound starting place with [code, papers, and more](https://imai.princeton.edu/projects/mechanisms.html). 

## How do I use `purging`?

Researchers should use `purging` if they are concerned mediation may be "canceling out" the effects of one variable as a result of another, when both are included in a single multivariate analysis. The idea behind the package then, is to generate the new direct-impact variable to be used in the analysis, _purged of the effects of the indirect variable_, simply by inputting the name of the data frame, direct variable, and indirect variable in the function. Calling the function will generate a new object (i.e., the variable), which can then be added to a data frame using the `$` operator in R, with the following line of code: `df$purged.var <- purged.var`.

Importantly, the package supports several functional forms, dependent on the mediating variable in question. These forms include linear for continuous data, logit and probit for binary data, and Poisson and negative binomial for event count data, where the functional form should be included after the `purge.` in the command (e.g., `purge.logit`). See the following three examples corresponding with each type of data.

```{r }
## First, linear/continuous example
df <- data.frame(A = 1:10, B = 2:11) # create continuous some data

purge.lm(df, "A", "B") # where, df = data frame; A = column name considered as "direct"; and B = column considered as "indirect"

## Second, logit/binary example
df <- data.frame(A = rep(0:1, 20), B = 1:20) # create some binary response data

purge.logit(df, "A", "B") # same syntax as above; To use the probit iteration, substitute `.logit` for `.probit`.

## Third, Poisson/counts example
df <- data.frame(A = c(1,1,1,1,1,2,2,2,3,4), B = 1:10) # create some count data

purge.poisson(df, "A", "B") # same syntax as above; To use the negative binomial iteration, substitute `.poisson` for `.negbin`.
```

## How do I get `purging `?

You can download the package and documentation at [CRAN](https://CRAN.R-project.org/package=purging). If you have any questions or find any bugs requiring fixing, please feel free to contact me.

## How do I cite `purging`?

A formal paper is being prepared and is hopefully coming soon. Stand by... 

But for now, you can manually cite it:

@Manual{waggoner2018purging,<br/>
    title = {purging: An R package for addressing mediation effects among independent variables},<br/>
    author = {Philip D. Waggoner},<br/>
    year = {2018},<br/>
    note = {R package version 1.0.0}<br/>
  }

Thanks and enjoy!
