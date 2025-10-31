# Data preparation

**Sourcing our data**

Originally, we were interested in credit loan data. From kaggle to machine learning papers, we identified two issues:

1. Given credit loan data involves highly personal information, datasets were often synthetic. This would limit the signifiance of our results given the lack of variation in the data.
2. Alternatively, datasets were highly convoluted - including over 100 variables without a clear dictionary

Our chosen bankruptcy dataset allowed us to explore a similar question without these issues. Tackling the above issues is possible but would require a significant amount of time, computational effort and access to sensitive information which stretches beyond the scope of this specific project and the resources available.

**Pre-processing the data**

One benefit of this data set is that it has no missing, imputed or synthetic data. The lack of missing data specifically is beneficial as we do not have to spend time imputing data which would involve e.g. justifying the use of the mean or median depending on the distribution of each variable. 

We also originally considered using status labels for years 1, 2, and 3 but removed these given that they risked introducing data leakage, giving the model future information about a company's bankruptcy that wouldn't be available at time _t_. [clarify more here]

However, we still identified a few key steps:

1. Removing companies that had entire missing years

Initially, we jumped straight to step 2. However, in calculating the number of companies with less than 3 years of record (using consecutive years and
distinct years), we noticed a discrepancy. This helped us identify that some companies had entire missing years which would cause our models to mistakenly refer
to an incorrect number of previous years (by skipping years) or require imputing data which would require additional assumptions.

2. Removing companies with less than 3 years of record

This would improve the quality of our predictions by removing companies that had very little information to train on.

3. Introduce lag variables

Lag variables gives our models information from previous to train on as we investigate the impact of more information on our model's predictive power.

4. Remove NAs from the dataset

By introducing lag variables, we introduce NAs as a company e.g. at the beginning of the dataset doesn't have previous years to refer to. Hence, we remove accordingly.

**Exploratory Data Analysis**

In plotting the distribution of our features, we noticed them being heavily skewed. To adjust for this, we standardised the features in the training set by subtracting the mean and dividing by the standard deviation.

However, the test set was more complicated because using the mean of the training set doesn't take in to account inflation. However, even after adjusting for this we still see the same skew. Furthermore, the company's growth over time isn't take in to account. Here, we identify a key point where expert knowledge would be greatly helpful in understanding how to take in to account such growth which stretches beyond our existing knowledge and the computational constraints of the project.

If we had more time, we would explore these two growth factors (inflation and company growth) in greater detail to make our model more generalisable. [clarify more here]

**Training, validation and test split**

We split the data by both company and time. This would prevent us from training the model on the data of a particular company, and then benefiting from that information in predicting its future. 












