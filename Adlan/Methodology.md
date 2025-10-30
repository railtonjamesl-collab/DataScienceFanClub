# Methodology

**Performance metric justification**

We decided on an ROC curve for 3 reasons:

1. Class imbalance: metrics like accuracy would not be suitable given the huge bias of the data towards non-bankrupt companies (around 93% were non-bankrupt). This is because a model could just guess non-bankrupt and be right most of the time. On the other hand, an ROC curve ignores class balance by looking at the true positive and false positive rate which isolates each class individually.

2. Visual aspect: an ROC curve is valuable in showing the trade off between the true positive and false positive rates at different points. Combined with the diagonal line representing a standard guess, this helps us more easily visualise the predictive performance of each iteration.

3. Threshold-Agnostic: metrics like an F1-score require you to pre-determine the threshold, evaluating the model at a specific point. An ROC curve, alternatively, plots every possible threshold, allowing us to see how the performance of the model changes at different points
