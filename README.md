# `purging` for mediation effects

#### Simple method for eliminating mediating impacts among independent variables

Let's say we had a causal model where womens' level of labor force participation determines their level of contraceptive use, and that the effect of female labor force participation on fertility is indirect, essentially filtered through its impact on contraceptive use. Once we account for contraceptive use, the direct effect of labor force participation (seen in the simple bivariate model, _labor.model_) goes away.

This is a simple way of thinking about mediation effects (e.g., a Mediation model:  LABOR (indirect) -> CONTRACEPT (direct) -> FERTILITY). If we run into this, a simple solution is to first regress contraceptive use on labor force participation. Then, we store those residuals. Then, we add the stored residuals as their own "variable" in the updated model specification. When we do this, we will see that each variable is explaining difference variable in the DV of interest. See the attached code file for the example; I thank Scott Basinger and Patrick Shea for the base of the example and data in their stats labs.
