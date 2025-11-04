## Logistic Regression

In this section we outline the approach to the binary classification problem using logistic regression and the results we found.

Logistic regression is a generalised linear model used to predict the binary outcome of an event. In this case the event is (1) Bankruptcy and (0) Non-Bankruptcy.

It works well with our dataset, in particular the flexibility with regards to what questions may be asked. Furthermore, many financial variables are continuous which makes it easier to use logistic regression. Given the large sample size of our data then logistic regression works well but may have bias, if so then there are multiple methods to help us with this fact [2], [3], [4].

Given the temporal nature of our dataset, it was important we split the data to minimise potential data leakage. This heavily impacts logistic regression does impact the independence assumption. Therefore, our results are not fully representative of what a correctly applied logisitc regression model would output. The incorportaion of lag variables nullifies the violation slightly, yet with more time it would be beneficial to fully explore ways to truly rectify the violation.

Now that we have discussed many of the issues encountered, the rest of this summary is in regards to the individual section.

### Individual Section Brief

My initial attempt at using logistic regression reported incredibly high accuracy, where the model was just choosing "alive" for every company in the dataset. This was partly due to the training set at hand and also the model, which were both later improved upon. After this, I implemented my logistic regression model on the training set, and then repeated 3 more times to incorporate all lag variables. This outputed AIC values for all the models. Given our performance metric was AUC, I did not dwell on these values too much, but it is worth to note that the base model and first year lag variables provided the lowest AIC, suggesting that that model is the best mix of fit and simplicity. I then computed the ROC/AUC for these models and found that the base model had the highest AUC score. This was surprising to me, but perhaps an explanation is the aforementioned independence violation, inflating its predictive power by spotting patterns. 

The next step was to repeat the analysis whilst removing highly correlated features. This lead to similar results, although the AUC slightly improved for the best model (once again base model). I then attempted to incorporate weightings, but realised that these were not really applicable [1]. I then moved onto penalisation techniques. I discovered that Logit Firth provides a slighlty better AUC, and that LASSO, Elastic Net and RIDGE all provide slightly lower ones. Given the latter three take into account all lag variables and penalise approproiately, then there models are probably better fit for the question at hand, although the independence assumption is still violated. I then ran the model on the test data and got similar results to what was reported on the validation set, with an AUC reported around 0.9. 

To conclude, the base model (with no lag features) reported back the highest AUC. This figure is likely inflated although we did take care in minimising this by splitting the data appropriately. Going forward more appropriate penalisation techniques such as LASSO or RIDGE may be used, although I tried to use the library for "geepack" and other alternatives but kept receiving many errors. For further study, it would be hugely worthwhile to explore these techniques as they tackle the issues that arise from temporal data [5].

References:
* [1] https://gking.harvard.edu/sites/g/files/omnuum7116/files/gking/file 
* [2] https://academic.oup.com/biomet/article/80/1/27/228364?login=true
* [3] https://glmnet.stanford.edu/articles/glmnet.html#logistic-regression-family-binomial 
* [4] https://statisticalhorizons.com/logistic-regression-for-rare-events/
* [5] https://www.jstatsoft.org/article/view/v015i02
