The html file is only included for 'results_analysis.Rmd'. This is because it takes a long time to run the training for support vector machine and conseuqently, knitting takes a long time. To mitigate for this the results optained from support_vector_machine_training.Rmd is saved in csv and is read directly into results_analysis.Rmd.

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

Under KKT assumption, solving for the dual problem is equivalent to solving for the primal. Oncethe problem is solved we can then define the optimal $w$ by $w = \sum_{i=1}^n y_i \alpha_i \phi(x_i)$ and the decision function is then given by 

$$
sgn(w^T\phi(x) + b) = sgn(\sum_{i=1}^n y_i \alpha_iK(x,x') + b)
$$

where K is a Kernel function. Here we only consider radial kernel given by,

$$
K(x,x') = exp(-\gamma||x-x'||^2),
$$

 where $\gamma$ is a scalar factor. Since in the context of high dimensional data we are using, it is safe to assume that the non linear boundary decision function would allow for a better flexibility in constructing a decision function.

 ## Limitation

 Firstly, in order to effectively use SVM the data needed to be standardised. As discussed previously in data processing section, the time drift makes the task less trivial than it seems. In this project we have not been able to come up with a clear solution, and therefore we except the potential bias introduce by imperfect standardisation.

 Secondly, the training time for SVM is extremely long compares to other methods, with the average training time for each run taking roughly ~10-20 minutes on AMD Ryzen 7 6800H processor, Nvidia Geforce RTX 3070 TI and 16GB of ram. For each lag features, SVM was tuned for cost margin 'c' and $\gamma$ of the kernel. 4 values for c and $\gamma$ was considered, totaling 64 runs to obtained all parameters. This takes roughly ~9-10 hours to train. Unfortunately, small interuption on the computer during this time result in the algorithm having to be redone. In hindsight, given more time SVM performance may be improve further by considered various other choices of kernel and also the abilities to fine tune the hyper parameter better with more values considered.





## Reference
[1] C.-C. Chang and C.-J. Lin (2011). *LIBSVM: A library for support vector machines*.  
    ACM Transactions on Intelligent Systems and Technology, 2(3), 1–27.  
    [https://www.csie.ntu.edu.tw/~cjlin/libsvm](https://www.csie.ntu.edu.tw/~cjlin/libsvm)
