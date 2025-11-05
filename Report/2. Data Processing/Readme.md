# Data preparation

**Sourcing our data**

Originally, we were interested in credit loan data. From kaggle to machine learning papers, we identified two issues:

1. Given credit loan data involves highly personal information, datasets were often synthetic. This would limit the significance of our results given the lack of variation in the data.
2. Alternatively, datasets were highly convoluted - including over 100 variables without a clear dictionary and explanation of what each variable meant

Our chosen bankruptcy dataset allowed us to explore a similar question without these issues. Tackling the above issues is possible but would require a significant amount of time, computational effort and access to sensitive information which stretches beyond the scope of this specific project and the resources available.

**Pre-processing the data**

One benefit of this data set is that it has no missing, imputed or synthetic data. The lack of missing data specifically is beneficial as we do not have to spend time imputing data which would involve e.g. justifying the use of the mean or median depending on the distribution of each variable. 

We also originally considered using status labels for years 1, 2, and 3 but removed these given that they risked introducing data leakage, giving the model future information about a company's bankruptcy that wouldn't be available at time _t_. 

However, we still identified a few key steps:

1. Removing companies that had entire missing years

Initially, we jumped straight to step 2. However, in calculating the number of companies with less than 3 years of record (using consecutive years and
distinct years), we noticed a discrepancy. This helped us identify that some companies had entire missing years which would cause our models to mistakenly refer
to an incorrect number of previous years (by skipping years) or require imputing data which would require additional assumptions.

2. Removing companies with less than 3 years of record

This would improve the quality of our predictions by removing companies that had very little information to train on.

3. Introduce lag variables

Lag variables gives our models information from previous years to train on as we investigate the impact of more information on our model's predictive power.

4. Remove NAs from the dataset

By introducing lag variables, we introduce NAs because a company e.g. at the beginning of the dataset doesn't have previous years to refer to. Hence, we remove accordingly.


**EDA and splitting the data in to our training, validation and test splits** 

Our _report EDA_ file and _completedataprocess_ files outlines in full detail the steps we took to plot the different features, how we scaled them and the full steps we took to process the data before 
running our different models. 














