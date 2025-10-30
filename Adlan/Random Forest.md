**Random Forests**

Here, we approach the binary classification problem using a random forest.

A random forest is made up of many individual decision trees. Each decision tree is trained on a bootstrapped sample of the data set (random sample with replacement) and we aggregate the predictions made by these trees to determine a final answer.

The advantage of this is that a single decision tree is sensitive to small changes in the training data which can lead to over-fitting. By iterating over many trees, we make our predictions more generalisable. 

**Dealing with a biased data set**

Given the data set being primarily composed of companies that didn't go bankrupt, we introduce the sampsize and strata functions to ensure the bankrupt companies are fairly represented in each bootstrapped sample. 

**Cross-validation**

Given the nature of a random forest, we have a unique way to approximate a cross validation. With each decision tree being trained on a bootstrapped sample, each tree doesn't see about one third of the data. Hence, we can test each tree on the data points it didn't see. We can use this to calculate the Out of Bag error rate as well as determine mean decrease accuracy which is explained below.

**Feature Importance**

We use two measures to gauge feature importance. Firstly, mean decrease accuracy measures how much our prediction accuracy decreases on average when we remove a particular feature. Our second measure looks at how important each feature is in terms of splitting the data at each node. 

**Model parameters**

Here, we went with the usual standard of each model seeing a subset of the features equal to the square root of the number of features. We also chose 500 trees as a balance between gaining depth in our prediction and minimizing computational power/time. 


