**Deciding the question**

We were interested in investigating the way company metrics could predict whether a company would go bankrupt. However, there are many variations of this question. We considered predictions based on data from one year prior to some n years prior.

We realised that this choice of question was a question in and of itself. That is to say, it would be interesting for us to not only investigate the relationship between a company’s metrics and their eventual bankruptcy, but how many years of prior information would be most optimal in predicting that bankruptcy.

Hence, we decided to investigate two questions:
1.	Given a company’s metrics in a given year, will they go bankrupt in the next year
2.	How does the number of years of information we give our model (1, 2 or 3 years) impact the accuracy of our predictions.
   
This way, we can investigate not only the relation between company metrics and bankruptcy but the benefit of having additional years of information. For the second part, this is highly useful in gauging how far out we can tell if a company is going bankrupt or if it is something only really decidable closer to the event.

**Pre-processing the data**

One benefit of this data set is that it has no missing, imputed or synthetic data. The lack of missing data specifically is beneficial as we do not have to spend time imputing data which would involve e.g. justifying the use of the mean or median depending on the distribution of each variable. 

However, we still identified 5 steps to clean the data before working with it. 

1.	Removing 710 companies that had entire missing years

Initially interested in removing companies with less than 3 years of data, we applied two methods (looking at distinct and consecutive years) and found a discrepancy in the number of remaining values. In trying to understand this, we identified the issue: some companies had entire missing years. 

This motivated our decision to remove these companies entirely from the dataset for two reasons: firstly, to avoid the model accidentally using data from two years ago when we’re only interested in the previous year. Secondly, imputing the values would introduce a lot of assumptions and be computationally intensive given the limited scope of the project.

2.	Removed companies that had less than 3 years of record

This would help avoid us training the data on companies with limited information which could skew the data and reduce the accuracy of our predictions.

3.	Introduce new status labels for 1,2 and 3 years to be specifically chosen depending on the number of previous years used

This reflects that for a given company in the dataset, a company that had Failed was listed as Failed for all the previous years.

4.	Introduce lag variables for three previous years
    
This would allow us our models to train on 1,2 and 3 years.

5.	Remove NA’s from the dataset

Our lag variables introduced NA’s given that a company e.g. at the start of the dataset cannot look back to previous years. 

**Data cleaning** 

In plotting the distribution of our variables, we notice that many of them are heavily skewed. To address this, we apply the log function which helps centre the distributions of the variables and approximates a normal distribution. 

**Our training split** 

Firstly, we decided to split our data into 1999-2011 (training set), 2012-2014 (validation set), 2015-2018 (test set). Splitting the companies chronologically helps us to avoid potential data leakage – training on future information to predict past information. 

Furthermore, by having the training set span both before and after the Great Financial Crisis, we avoid the model being overly influenced by 2008 which was a key outlier. 

Secondly, we split our data by company. This is because training on a company’s past data could benefit the model’s ability to predict future information.




