# Support Vector Machine

Support Vector Machines (SVM) are a supervised learning algorithm designed primarily for binary classification, with foundations in statistical learing and convex optimization. The core idea here is to find a decision boundary which best seperate the binary classes by maximizing the margin (distance between the boundary and the nearest data point of each class.) There are multiple ways to formulate an SVM algorithm here we summarise the optimization used in R package 'e1071' default svm settings based on (https://www.csie.ntu.edu.tw/~cjlin/libsvm) [1]. 

## Support Vector Machine Optimization
Given $x_i \in \mathcal{R}^d for i=1\dots n$ with indicators $y_i \in {1,-1}$ we aim to solve a dual problem. The primal problem is given by

$$
min_{(w,b,\varepsilon)} \frac{1}{2}w^Tw + C\sum_{i=1}^n \varepsilon_i
$$

subjected to,

$$
y_i(w^T\phi(x_i) + b) \geq 1-\epsilon_i.
$$
And the dual problem is given by,
$$
min_{\alpha} \frac{1}{2}\alpha^TQ\alpha - e^T\alpha,
$$

subjected to

$$
y^T\alpha = 0, \quad 0 \leq \alpha_i \leq C, \quad i=1,\dots,n.
$$

Under KKT assumption, solving for the dual problem is equivalent to solving for the primal. Oncethe problem is solved we can then define the optimal $w$ by $w = \sum_{i=1}^n y_i \alpha_i \phi(x_i)$




## Reference
[1] C.-C. Chang and C.-J. Lin (2011). *LIBSVM: A library for support vector machines*.  
    ACM Transactions on Intelligent Systems and Technology, 2(3), 1–27.  
    [https://www.csie.ntu.edu.tw/~cjlin/libsvm](https://www.csie.ntu.edu.tw/~cjlin/libsvm)
