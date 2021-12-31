---
title: "Modeling and prediction for movies"
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
library(knitr)  

```

### Load data

Make sure your data and R Markdown files are in the same directory. When loaded
your data file will be called `movies`. Delete this note when before you submit 
your work. 

```{r load-data}
setwd("/Users/randyasfandy/Desktop/Data Science/Statistic/Linear Regression and Modelling/Final Project")
load("movies.Rdata")
str(movies)

```



* * *

## Part 1: Data

The data set is contained from 651 random sampled movies.
These data can be generalizable because random sampling and assignment were applied.



## Part 2: Research question

Paramount pictures want to know the specifics who make film popular.
As a significant indicator of mostly known and popular film, I choosed imdb_rating
as a popularity factor.

Is the explanatory variable is significant predictor for imdb_rating?
(Popularity of the selected film)

Ho = No nothing going on.
The explanatory variable is not a significant predictor of the response variable.
(Slope of the relationship is zero.(B1=0))

My response variable is imdb_rating.
Now it is time to set explanatory variables.

Is the explanatory variable is significant predictor for imdb_rating?
(Popularity of the selected film)


## Part 3: Exploratory data analysis

NOTE: Insert code chunks as needed by clicking on the "Insert a new code chunk" 
button above. Make sure that your code is visible in the project you submit. 
Delete this note when before you submit your work.

* * *



```{r }

movies <- na.omit(movies)
 
ggplot(data=movies, aes(x=audience_rating ,y=imdb_rating, colour=critics_rating))+geom_point() + geom_smooth(method = "lm", se = FALSE) + facet_wrap(~top200_box)

ggplot(data=movies, aes(x=audience_score ,y=imdb_rating, colour=critics_rating))+geom_point() + geom_smooth(method = "lm", se = FALSE) + facet_wrap(~best_actor_win)

ggplot(data=movies, aes(x=audience_score ,y=imdb_rating, colour=critics_rating))+geom_point() + geom_smooth(method = "lm", se = FALSE) + facet_wrap(~best_actress_win)

ggplot(data=movies, aes(x=audience_score ,y=imdb_rating, colour=critics_rating))+geom_point() + geom_smooth(method = "lm", se = FALSE) + facet_wrap(~best_pic_win)

ggplot(data=movies, aes(x=audience_score ,y=imdb_rating, colour=critics_rating))+geom_point() + geom_smooth(method = "lm", se = FALSE) + facet_wrap(~best_pic_win)

ggplot(data=movies, aes(x=audience_score ,y=imdb_rating, colour=critics_rating))+geom_point() + geom_smooth(method = "lm", se = FALSE) + facet_wrap(~genre)

ggplot(data=movies, aes(x=audience_score ,y=imdb_rating, colour=critics_rating))+geom_point() + geom_smooth(method = "lm", se = FALSE) + facet_wrap(~mpaa_rating)

cor(movies$imdb_rating, movies$critics_score)
0.762
cor(movies$imdb_rating, movies$audience_score)
0.8605425
cor(movies$audience_score, movies$critics_score)
0.7015256
#This correlation coefficients is quite high, so we would not want to add critics_score because these two variables are highly associated, it may result multicollinearity.












```









## Part 4: Modeling

### Explanatory variables

1. genre
2. runtime
3. mpaa_Rating
4. imdb_num_votes
5. audience_rating
6. best_pic_win
7. best_actor_win
8. best_actress_win
9. best_dir_win
10. top200_box

'director' have been eliminated as when adding them the conditions for the MLR model are not met.
I am going to apply backward selection.

Hence our response variable is imdb_rating, we will change the other variables to improve
our adjusted r squared.
```{r}


model0<- lm(imdb_rating ~ +audience_score + genre + runtime + mpaa_rating + imdb_num_votes +  audience_rating + best_pic_nom + best_pic_win + best_actor_win+best_actress_win+best_dir_win + top200_box , data=movies)
summary(model0)

# adjusted r-squarred : 0.7884

model1 <- lm(imdb_rating ~ +audience_score + genre + runtime + mpaa_rating + imdb_num_votes +  audience_rating + best_pic_nom + best_pic_win + best_actor_win+best_actress_win+best_dir_win , data=movies)

#adjusted r-squarred : 0.7887

# Subtracting top200_box raised R squarred.

model2 <- lm(imdb_rating ~ +audience_score + genre + runtime + mpaa_rating +  audience_rating + best_pic_nom + best_pic_win + best_actor_win+best_actress_win+best_dir_win , data=movies)


#imdb rating subtracting decreased R squarred.
# 0.7834369

 model3 <- lm(imdb_rating ~ +audience_score + genre + runtime + mpaa_rating + imdb_num_votes +  audience_rating + best_pic_nom + best_pic_win +best_actress_win+best_dir_win , data=movies)
 
#adjusted r-squarred : 0.789

# Subtracting best_actor_win raised R squarred.

model4 <- lm(imdb_rating ~ +audience_score + genre + runtime + mpaa_rating + imdb_num_votes +  audience_rating + best_pic_nom + best_pic_win +best_dir_win , data=movies)

#best_actress_win subtracting decreased R squarred.
# 0.788

model5 <- lm(imdb_rating ~ +audience_score + genre + mpaa_rating + imdb_num_votes +  audience_rating + best_pic_nom + best_pic_win +best_dir_win , data=movies)


#run_time subtracting decreased R squarred.
#0.783

model6 <- lm(imdb_rating ~ +audience_score + genre + runtime + mpaa_rating + imdb_num_votes +  audience_rating + best_pic_nom +best_dir_win , data=movies)


#best_pic_win subtracting increased R squarred.

#adjusted r squarred 0.789

model7 <- lm(imdb_rating ~ +audience_score + genre + runtime + mpaa_rating + imdb_num_votes +  audience_rating + best_pic_nom , data=movies)

#best_dir_win subtracting decreased R squarred.

#adjusted r squarred 0.788

model8 <- lm(imdb_rating ~ audience_score + genre + runtime + mpaa_rating + imdb_num_votes  + best_pic_nom +best_dir_win , data=movies)

#audience_rating subtracting decreased R squarred.
#adjusted r squarred 0.779



```



###Diagnostic of multiple linear regression

#### 1)Linear relationship between numerical x and y 

```{r}
par(mfrow=c(1,2))
plot(model8$residuals ~ movies$audience_score)
plot(model8$residuals ~ movies$runtime)
```




#### 2)Nearly normal residuals with mean 0 

```{r}
hist(model8$residuals)
qqnorm(model8$residuals)
qqline(model8$residuals)
```



#### 3)Constant variability of residuals


```{r}
plot(model8$residuals ~ model8$fitted.values)
plot(abs(model8$residuals) ~ model8$fitted.values)

```

Residuals should be equally variable.
Residuals randomly scattered in a band with a constant width around zero.
(No fan shape)

#### 4)Independent residuals 

The data have been randomly sampled as it was stated at the beginning of the report. Therefore the condition is also met.





## Part 5: Prediction

```{r }

new=data.frame(audience_score=c(70),
genre="Mystery & Suspense",runtime=c(124),mpaa_rating="R",imdb_num_votes =c(259822),best_pic_nom="no",best_dir_win="no")
               

predict(model8, newdata=new, interval="prediction", level = 0.95)

predict(model8,new)

```

## Part 6: Conclusion

The predictive model presented here is used to predict imdb_rating for a movie.
The key to the success of a film lays in the difussion it may get.
According to the Multiple Linear Regression model if we define imdb_rating as an response
variable and choose exlanatory variable as imdb_num_votes, best_pic_nom, best_dir_win, audience_score, mpaa_rating, runtime and genre, we can predict films score and get too little
margin of error.

We can be 95% confident that the actual imdb score for this particular movie has a lower bound
of approximately 6.28 and a higher bound of approximately 7.28.

Die hard-2 imdb rating is 7.1
Our prediction is 7.28.
Margin of error is %2.5, which seems enough.





