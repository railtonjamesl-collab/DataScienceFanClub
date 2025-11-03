# Conclusion


**Key Takeaways**


**Further topics for exploration**

Given our limited time and resources, we had to be selective in what we chose to work on. However, we identified a few further areas for exploration were we to have more time or for those interested in building upon our results further. 

Firstly, we could explore more intricate methods of cross-validation. Usual in-built methods of cross validation in methods like Random Forests or KNN-neighbours were not applicable here given the data not being independent, risking data leakage. As a result, we used a single fold to validate our models. We did apply k-folds to XGboost, however, we didn't have the time to implement this to all of the other models. It would be interesting to see if doing this would change the optimal feature combination for each model and the final result. 

Secondly, a major line of investigation would be adjusting for inflation and company growth. In normalising our training set, we naturally use the mean of the training set. However, for the test set, to simplify using the mean of the training data wouldn't properly take in to account both inflation and the natural growth of the company. Over a shorter-term period this isn't as significant, however, it certainly is an important factor for time series and financial data. For us, this highlights the importance of expert knowledge which would allow us to better understand the implications of these factors and how to investigate them. 

Thirdly, 


using neural networks, risk of overfitting 










