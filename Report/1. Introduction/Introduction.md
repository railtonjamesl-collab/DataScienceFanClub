# Data Science Toolbox Assessed Coursework 1 : Supervised Prediction


**Our goal**

This project looks at a finance dataset from Kaggle outlining a company's metrics over time and their bankruptcy status. 

We were interested in solving the binary classification problem: given a company's metrics in a certain year _n_, will it go bankrupt in year _n_. We specifically wanted to investigate how our prediction power would change as we introduced additional company metrics from years _n-1_, _n-2_ and _n-3_. 

Our chosen models include a Random Forest, XGboost, logistic regression, K Nearest Neighbours and SVM. We aim to explore how these models perform according to our chosen performance metric AUC.

For each model, we will train it on the training set and test it on the validation set to determine which combination of years produced the highest AUC value. Then, each model will use their best combination of years to train on the entire training set before finally testing on the test set. Finally, we can then compare which model has the highest AUC value when tested on the unseen data.

**Our motivation**

In the context of finance, the result of this report is hugely beneficial in understanding how far out from a certain year can we forecast a company's bankruptcy status. This would be important for companies to monitor their own risk of bankruptcy. Investors can also find this useful in either identifying when to sell investments or to actually invest in failing companies - an area of finance referred to as distressed debt where failing companies are bought, improved and sold for a profit. 

Furthermore, our results will help highlight which types of models are most suitable for time series and bankruptcy data. 
















