---
title: "Statistical inference with the GSS data"
output: 
  html_document: 
    fig_height: 4
    highlight: pygments
    theme: spacelab
---

## Setup

### Load packages

```{r load-packages, message = FALSE}
library(ggplot2)
library(dplyr)
library(statsr)
```

### Load data

Make sure your data and R Markdown files are in the same directory. When loaded
your data file will be called `gss`. Delete this note when before you submit 
your work. 

```{r load-data}
load("gss.Rmd")
```



* * *

## Part 1: Data


GSS data was obtained by face-to-fce interview (vast majority), computer-assisted personal interview (CAPI) (began 2002), or telephone. Source of bias: due to long interview, there are number of people who do not participate in the interviews or do not fully answer the questions.

Scope of inference-generalization: the data consists of 57061 people from American society with random sampling. Hence, this study has generalization.

Scope of inference-causation: this is an observational study and has no causation. Only correlation could be established using statistical inference.

## Part 2: Research question

IF gender status and drug addiction is independent or associated?


## Part 3: Exploratory data analysis,

```{r}


load("gss.Rmd")
#to load data properly

mosaicplot(table(gss$natdrug, gss$sex)) 
#to see overall shape firstly

by(gss$natdrug, gss$sex, summary) 
#to do calculation manually to double check.

```


* * *

## Part 4: Inference

Because of that we have two categorical variable and one of them has more than two level, we are going to use chi independence test.
But first we have to check conditions.
1)Independence:

Random assignment has been done by GSS.
n< 10, total male number:25146 < Male population, total female number:31915 < Female Population
each case only contributed to  one cell in table as it seems.

2)Sample Size:Each cell have at least 5 case.

Conditions are matched.

Ho:The two variables are independent.
Ha:The two variables are associated.




pchisq(117,39, 2, lower.tail=FALSE)

Output=nearly zero

inference(y = sex, x = natdrug, data = gss, statistic = "proportion", type = "ht", method = "theortical", alternative = "greater", order = c("smoker","nonsmoker"))

Output= chi_sq=117.3899, df=2, p_value=0

we can double check with this function;

chisq.test(table(gss$sex, gss$natdrug))

Output= chi-sq=117.39, df=2, p-value = 2.2e-16 , it means nearly zero.



P value < significance level;

We reject the null value, and accept the alternative hypothesis.

Conclusion:

It means the drug addiction is associated with gender status, because P value < significance level, that means we will reject the null value and accept the hypothesis
in favor of alternative.






