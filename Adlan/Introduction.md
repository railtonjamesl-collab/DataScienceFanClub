# Data Science Toolbox Assessed Coursework 1 : Supervised Prediction


**Our goal**

This project looks at a finance dataset from Kaggle outlining company metrics over time and their bankruptcy status. We were interested in solving the binary classification problem: given a company's metrics in a certain year _n_, will it go bankrupt in year _n_. We were then interested in determining the importance of different features and exploring how the quality of our predictions would change as we introduced additional company metrics from years _n-1_, _n-2_ and _n-3_. 

Our chosen models include a Random Forest, XGboost, logistic regression, K Nearest Neighbours andd [insert here]. Here, we aim to not just answer the binary classification problem but to explore how these different models compare according to our chosen performance metric.

To do this, we will pre-process the data, split it in to a training and test set, run our different models and draw conclusions based on their different results.

**Deciding on our dataset**

Originally, we were interested in credit loan data. From kaggle to machine learning papers, we identified two issues:

1. Given credit loan data involves highly personal information, datasets were often synthetic. This would limit the signifiance of our results given the lack of variation in the data.
2. Alternatively, datasets were highly convoluted - including over 100 variables without a clear dictionary

Our chosen bankruptcy dataset allowed us to explore a similar question without these issues. Tackling the above issues is possible but would require a significant amount of time, computational effort and access to sensitive information which stretches beyond the scope of this specific project and the resources available.











