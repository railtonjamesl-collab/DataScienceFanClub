Pre-processing the data
One benefit of this data set is that it has no missing, imputed or synthetic data. The lack of missing data specifically is beneficial as we do not have to spend time imputing data which would involve e.g. justifying the use of the mean or median depending on the distribution of each variable. 
However, we still identified 3 steps to clean the data before working with it. 
Firstly, companies that had gone bankrupt were listed as Failed in all previous years. Hence, we changed all the years prior to the final Failed year as Alive. We briefly considered introducing a new category Dying to reflect a company that was Alive but soon to go bankrupt, however, we realised that this would mean the model would have access to future information leading to data leakage.
Secondly, we excluded companies that had less than 3 years of data in the dataset. This would help avoid us training the data on companies with limited information which could skew the data and reduce the accuracy of our predictions.
Thirdly, (not sure how to write this part about lag features so TBC).
Deciding the question
We were interested in investigating the way company metrics could predict whether a company would go bankrupt. However, there are many variations of this question. We considered predictions based on data from one year prior to some n years prior.
We realised that this choice of question was a question in and of itself. That is to say, it would be interesting for us to not only investigate the relationship between a company’s metrics and their eventual bankruptcy, but how many years of prior information would be most optimal in predicting that bankruptcy.
Hence, we decided to investigate two questions:
1.	Given a company’s metrics in a given year, will they go bankrupt in the next year
2.	How does the number of years of information we give our model (1, 2 or 3 years) impact the accuracy of our predictions. 
This way, we can investigate not only the relation between company metrics and bankruptcy but the benefit of having additional years of information. For the second part, this is highly useful in gauging how far out we can tell if a company is going bankrupt or if it is something only really decidable closer to the event.
Our training split 
Firstly, we decided to split our data into 1999-2011 (training set), 2012-2014 (validation set), 2015-2018 (test set). Splitting the companies chronologically helps us to avoid potential data leakage – training on future information to predict past information. Furthermore, by having the training set span both before and after the Great Financial Crisis, we avoid the model being overly influenced by 2008 which was a key outlier. 
Secondly, we split our data by company. This is because training on a company’s past data could benefit the model’s ability to predict future information.


