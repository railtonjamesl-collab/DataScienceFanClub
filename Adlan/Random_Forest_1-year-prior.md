A random forest is an aggregation method which means we use predictions
made from many decision trees to solve our binary classification
problem.

One key advantage is that a single decision tree is sensitive to small
changes in training data. By iterating over many decision trees that use
different subsamples of the features and dataset, we reduce the
importance of our training data and reduce overfitting — helping our
model generalize as opposed to being specific to certain training data.

``` r
library(tidyverse)
```

    ## Warning: package 'tidyverse' was built under R version 4.2.3

    ## Warning: package 'ggplot2' was built under R version 4.2.3

    ## Warning: package 'tibble' was built under R version 4.2.3

    ## Warning: package 'tidyr' was built under R version 4.2.3

    ## Warning: package 'readr' was built under R version 4.2.3

    ## Warning: package 'purrr' was built under R version 4.2.3

    ## Warning: package 'dplyr' was built under R version 4.2.3

    ## Warning: package 'lubridate' was built under R version 4.2.3

    ## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ## ✔ dplyr     1.1.4     ✔ readr     2.1.5
    ## ✔ forcats   1.0.1     ✔ stringr   1.5.0
    ## ✔ ggplot2   3.5.1     ✔ tibble    3.2.1
    ## ✔ lubridate 1.9.3     ✔ tidyr     1.3.1
    ## ✔ purrr     1.0.2     
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()
    ## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` r
library(randomForest)
```

    ## Warning: package 'randomForest' was built under R version 4.2.3

    ## randomForest 4.7-1.1
    ## Type rfNews() to see new features/changes/bug fixes.
    ## 
    ## Attaching package: 'randomForest'
    ## 
    ## The following object is masked from 'package:dplyr':
    ## 
    ##     combine
    ## 
    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     margin

``` r
library(pROC)
```

    ## Warning: package 'pROC' was built under R version 4.2.3

    ## Type 'citation("pROC")' for a citation.
    ## 
    ## Attaching package: 'pROC'
    ## 
    ## The following objects are masked from 'package:stats':
    ## 
    ##     cov, smooth, var

``` r
# Function to train RF on a single year
train_rf_year <- function(train_file, test_file, year_suffix, seed=123) {
  # Load data
  train_data <- read.csv(train_file)
  test_data <- read.csv(test_file)
  
  # Target and predictor columns for this year
  target_col <- paste0("status_label_", year_suffix, "yr")
  train_data <- train_data %>% select(all_of(target_col), ends_with(paste0("_", year_suffix, "yr")))
  test_data <- test_data %>% select(all_of(target_col), ends_with(paste0("_", year_suffix, "yr")))
  
  # Convert target to factor
  train_data[[target_col]] <- as.factor(train_data[[target_col]])
  test_data[[target_col]] <- as.factor(test_data[[target_col]])
  
  train_data[[target_col]] <- droplevels(train_data[[target_col]])
  test_data[[target_col]] <- droplevels(test_data[[target_col]])
  
  # Train Random Forest
  set.seed(seed)
  rf_model <- randomForest(
    formula = as.formula(paste(target_col, "~ .")),
    data = train_data,
    ntree = 500,
    mtry = sqrt(ncol(train_data)-1),
    importance = TRUE,
    strata = train_data[[target_col]],
    sampsize = rep(min(table(train_data[[target_col]])), 2)
  )
  
  # Predictions and ROC
  prob_test <- predict(rf_model, test_data, type="prob")[,2]
  roc_obj <- roc(test_data[[target_col]], prob_test)
  auc_value <- auc(roc_obj)
  
  return(list(model=rf_model, roc=roc_obj, auc=auc_value))
}

# Train separate models for each year
rf_1yr <- train_rf_year("../data/train_scaled.csv", "../data/test_scaled.csv", 1)
```

    ## Setting levels: control = alive, case = failed
    ## Setting direction: controls < cases

``` r
rf_2yr <- train_rf_year("../data/train_scaled.csv", "../data/test_scaled.csv", 2)
```

    ## Setting levels: control = alive, case = failed
    ## Setting direction: controls < cases

``` r
rf_3yr <- train_rf_year("../data/train_scaled.csv", "../data/test_scaled.csv", 3)
```

    ## Setting levels: control = alive, case = failed
    ## Setting direction: controls < cases

``` r
# Compare AUCs
auc_df <- data.frame(
  Year = c("1-Year", "2-Year", "3-Year"),
  AUC = c(rf_1yr$auc, rf_2yr$auc, rf_3yr$auc)
)
print(auc_df)
```

    ##     Year       AUC
    ## 1 1-Year 0.8316045
    ## 2 2-Year 0.7568592
    ## 3 3-Year 0.7105754

``` r
# Plot ROC curves for each year separately
plot(rf_1yr$roc, col="#1b9e77", lwd=2, main="ROC Curves by Year")
lines(rf_2yr$roc, col="#d95f02", lwd=2)
lines(rf_3yr$roc, col="#7570b3", lwd=2)
abline(a=0, b=1, lty=2, col="gray")
legend("bottomright", legend=paste(c("1-Year","2-Year","3-Year"), "AUC=", round(c(rf_1yr$auc, rf_2yr$auc, rf_3yr$auc), 3)),
       col=c("#1b9e77","#d95f02","#7570b3"), lwd=2, bty="n")
```

![](Random_Forest_1-year-prior_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

``` r
# Feature importance for 1-year model (most recent year)
varImpPlot(rf_1yr$model, main="Variable Importance - 1-Year Features")
```

![](Random_Forest_1-year-prior_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->
