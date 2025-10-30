**Random Forest Methodology**

Here, we approach the binary classification problem using a random forest.

A random forest is made up of many individual decision trees. Each decision tree is trained on a bootstrapped sample of the data set (random sample with replacement) and we aggregate the predictions made by these trees to determine a final answer.

The advantage of this is that a single decision tree is sensitive to small changes in the training data which can lead to over-fitting. By iterating over many trees, we make our predictions more generalisable. 

Given the data set being primarily composed of companies that didn't go bankrupt, we introduce the sampsize and strata functions to ensure the bankrupt companies are fairly represented in each bootstrapped sample. 


