# Data Science Toolbox Assessed Coursework 1 : Supervised Prediction


**Structure of the project**

1. Introduction
   - Our goal

2. Data Preparation
   - Deciding on our dataset
   - Pre-processing of our data
   - Exploratory data analysis

3. Methodology
   - Determining which features to use in the test set

4. Results and Discussion
   - Result of each model being run on the test set
   - Aggregating and interpreting our results

5. Conclusion
   - Key takeaways
   - Further options for exploration

**Our goal**

This project looks at a finance dataset from Kaggle outlining company metrics over time and their bankruptcy status. We were interested in solving the binary classification problem: given a company's metrics in a certain year _n_, will it go bankrupt in year _n_. We were then interested in determining the importance of different features and exploring how the quality of our predictions would change as we introduced additional company metrics from years _n-1_, _n-2_ and _n-3_. 

Our chosen models include a Random Forest, XGboost, logistic regression, K Nearest Neighbours and SVM. Here, we aim to not just answer the binary classification problem but to explore how these different models compare - using our chosen performance metric to gauge the relative fit and suitability of each model for this specific problem. 

For each model, we will train it on the training set and test it on the validation set to determine which number of features produced the highest AUC value. Then, that specific feature selection will be used to train on the entire training set before finally testing on the test set. 














