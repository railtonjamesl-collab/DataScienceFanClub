# Conclusion


This project aimed to develop and compare a range of classification and regression models to predict whether a company would go bankrupt within the following year, using panel data containing annual financial indicators. The process provided valuable experience in handling real-world data, particularly the challenges of cleaning, restructuring, and dealing with imbalanced and dependent observations. Although the final models varied in performance, the project achieved its goal of exploring different modelling approaches and evaluating their suitability for financial prediction tasks.

A significant portion of the project was dedicated to exploratory data analysis and preprocessing, which were crucial to ensuring data quality before modelling. The dataset initially contained inconsistencies, missing years, and incorrectly labelled target values. These issues were addressed through data cleaning and reformatting. Scaling was also an essential preprocessing step to ensure that all variables contributed equally to the model. Since financial indicators were measured on different scales, standardising the data prevented features with larger numerical ranges from dominating distance-based algorithms like KNN and SVM. These steps were vital for improving comparability across companies and ensuring the reliability of the final results.	

Among the models tested; logistic regression, random forest, SVM, XGBoost, and KNN, the random forest model achieved the highest AUC and overall balanced accuracy, indicating that it best distinguished between bankrupt and solvent companies. KNN, by contrast, performed less effectively, likely due to the high dimensionality and imbalance of the data, which can cause distance-based methods to misclassify minority cases. Nevertheless, the KNN experiments were useful for understanding how parameter tuning and resampling methods such as SMOTE and up-sampling influence model performance.

The results highlight the importance of data preprocessing and model selection when working with financial data. Even small changes to scaling, sampling strategy, or feature inclusion can significantly affect predictive power.

Future work could explore more intricate methods of cross-validation. Usual in-built methods of cross validation in methods like Random Forests or KNN-neighbours were not applicable here given the data not being independent, risking data leakage. As a result, we used a single fold to validate our models. We did apply k-folds to XGboost, however, we didn’t have the time to implement this to all of the other models. It would be interesting to see if doing this would change the optimal feature combination for each model and the final result.

Another major line of investigation would be adjusting for inflation and company growth. In normalising our training set, we naturally use the mean of the training set. However, for the test set, to simplify using the mean of the training data wouldn’t properly take into account both inflation and the natural growth of the company. Over a shorter-term period this isn’t as significant, however, it certainly is an important factor for time series and financial data. For us, this highlights the importance of expert knowledge which would allow us to better understand the implications of these factors and how to investigate them.

Overall, this project demonstrated the complexities of applying predictive modelling to real-world financial problems and the value of evaluating multiple approaches. It reinforced the need for careful data handling, thoughtful metric selection, and critical interpretation of results.











