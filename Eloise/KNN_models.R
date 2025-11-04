library(caret)
library(dplyr)
library(pROC)


# set working directory 
setwd("C:/Users/elois/OneDrive/Documents/University of Bristol/Semester 1/Data Science Toolbox/Assessments/Assessment 1/DataScienceFanClub")

set.seed(123)

# import data sets to train with

val_train <- read.csv("data/Val_traindata/df_train_log_scaled_val.csv")
val_test <- read.csv("data/Val_traindata/df_test_log_scaled_val.csv")

# make sure target vars are factors

feature_lag0 = c('X1','X2','X3','X4','X5','X6','X7','X8','X9','X10','X11','X12','X13','X14','X15','X17','X18')
feature_lag1 = c(feature_lag0, 'X1_1yr','X2_1yr','X3_1yr','X4_1yr','X5_1yr','X6_1yr','X7_1yr','X8_1yr','X9_1yr','X10_1yr','X11_1yr','X12_1yr','X13_1yr','X14_1yr','X15_1yr','X17_1yr','X18_1yr')
feature_lag2 = c(feature_lag1, 'X1_2yr','X2_2yr','X3_2yr','X4_2yr','X5_2yr','X6_2yr','X7_2yr','X8_2yr','X9_2yr','X10_2yr','X11_2yr','X12_2yr','X13_2yr','X14_2yr','X15_2yr','X17_2yr','X18_2yr')
feature_lag3 = c(feature_lag2, 'X1_3yr','X2_3yr','X3_3yr','X4_3yr','X5_3yr','X6_3yr','X7_3yr','X8_3yr','X9_3yr','X10_3yr','X11_3yr','X12_3yr','X13_3yr','X14_3yr','X15_3yr','X17_3yr','X18_3yr')


# base model

x_train_base <-  val_train[, feature_lag0]
x_test_base <- val_test[, feature_lag0]

y_train_base <- factor(val_train[,'status_label_1yr'])
y_test_base <- factor(val_test[,'status_label_1yr'])

# lag data 

# 1 yr

x_train_lag1yr <- val_train[, feature_lag1]
x_test_lag1yr <- val_test[, feature_lag1]

y_train_lag1yr <- factor(val_train[, "status_label_1yr"])
y_test_lag1yr <- factor(val_test[, "status_label_1yr"])

# 2yr

x_train_lag2yr <- val_train[, feature_lag2]
x_test_lag2yr <- val_test[, feature_lag2]

y_train_lag2yr <- factor(val_train[, "status_label_1yr"])
y_test_lag2yr <- factor(val_test[, "status_label_1yr"])

# 3yr

x_train_lag3yr <- val_train[, feature_lag3]
x_test_lag3yr <- val_test[, feature_lag3]

y_train_lag3yr <- factor(val_train[, "status_label_1yr"])
y_test_lag3yr <- factor(val_test[, "status_label_1yr"])


ctr <- trainControl(method = "none",
                    sampling = NULL)

knnModel <- train(
  x = x_train_base, 
  y = y_train_base,
  method = "knn",
  tuneGrid = data.frame(k = 5),
  trControl = ctr
)

# trControl - something to do with crossvalidation
# tune length can be changed to make it more accurate - how are the different k values found for this 

# model summary 
print(knnModel)

# predict on test set for classification 

pred_class <- predict(knnModel, newdata = x_test_base, type = "raw")

# evaluate performance

conf_matrix <- confusionMatrix(pred_raw, y_test_base)
print(conf_matrix)

# This has predicted all are alive. therefore this a case of class imbabalce.

# predict on test set for probabilities

pred_prob <- predict(knnModel, newdata = x_test_base, type = "prob")

# Roc curve 
roc_obj <- roc(y_test_base, pred_prob[, "failed"])

plot(roc_obj)

#  auc
auc_value <- auc(roc_obj)
print(auc_value)

# Variable Importance 

var_imp <- varImp(knnModel, scale = TRUE)
print(var_imp)
plot(var_imp)

KNN_manual <- function(train_x, train_y, test_x, test_y, resampling) {
  
  set.seed(123)
  
  # Use only odd K values (to avoid ties)
  k_values <- seq(1, 101, by = 2)
  
  # Control (no internal cross-validation)
  ctrl <- trainControl(
    method = "none",
    classProbs = TRUE,
    sampling = resampling
  )
  
  results <- data.frame(k = integer(), Accuracy = numeric(), AUC = numeric())
  models <- list()
  
  for (k in k_values) {
    
    # Train model
    knnModel <- train(
      x = train_x,
      y = train_y,
      method = "knn",
      tuneGrid = data.frame(k = k),
      trControl = ctrl
    )
    
    # Predictions (class)
    pred_class <- predict(knnModel, newdata = test_x, type = "raw")
    conf <- confusionMatrix(pred_class, test_y)
    
    # Predictions (probabilities)
    pred_prob <- predict(knnModel, newdata = test_x, type = "prob")
    
    # ROC + AUC
    roc_obj <- tryCatch({
      roc(test_y, pred_prob[, "failed"], quiet = TRUE)
    }, error = function(e) NA)
    
    auc_val <- if (!is.na(roc_obj)[1]) auc(roc_obj) else NA
    
    # Store performance
    results <- rbind(results, data.frame(
      k = k,
      Accuracy = conf$overall["Accuracy"],
      AUC = auc_val
    ))
    
    # Store model info
    models[[paste0("k_", k)]] <- list(
      model = knnModel,
      conf = conf,
      roc = roc_obj,
      auc = auc_val
    )
  }
  
  # Find best model (prioritize AUC, fallback to Accuracy if AUC missing)
  if (all(is.na(results$AUC))) {
    best_k <- results$k[which.max(results$Accuracy)]
    metric_used <- "Accuracy"
  } else {
    best_k <- results$k[which.max(results$AUC)]
    metric_used <- "AUC"
  }
  
  best_model <- models[[paste0("k_", best_k)]]
  
  # Summary printout
  message(paste0("✅ Best K = ", best_k, " (based on ", metric_used, ")"))
  message(paste0("   Accuracy: ", round(best_model$conf$overall["Accuracy"], 4)))
  if (!is.na(best_model$auc)) message(paste0("   AUC: ", round(best_model$auc, 4)))
  
  # Return everything
  return(list(
    k = best_k,
    model = best_model$model,
    conf_matrix = best_model$conf,
    roc = best_model$roc,
    auc = best_model$auc,
    all_results = results,
    all_models = models
  ))
}

# models for base data 

knn_basic <- KNN_manual(x_train_base, y_train_base, x_test_base, y_test_base, NULL)
knn_us <- KNN_manual(x_train_base, y_train_base, x_test_base, y_test_base, "up")
knn_smote <- KNN_manual(x_train_base, y_train_base, x_test_base, y_test_base, "smote")

# models for 1yr data

knn_basic <- KNN_manual(x_train_base, y_train_base, x_test_base, y_test_base, NULL)
knn_us <- KNN_manual(x_train_base, y_train_base, x_test_base, y_test_base, "up")
knn_smote <- KNN_manual(x_train_base, y_train_base, x_test_base, y_test_base, "smote")

# 

print(knn_basic$model)
print(knn_basic$conf_matrix)
plot(knn_basic$roc)
print(knn_basic$auc)
print(knn_basic$var_imp)
plot(knn_basic$var_imp)

knn_basic_10 <- KNN_model(x_train_base, y_train_base, x_test_base, y_test_base, 10, NULL)

print(knn_basic$model)
print(knn_basic$conf_matrix)
plot(knn_basic$roc)
print(knn_basic$auc)
print(knn_basic$var_imp)
plot(knn_basic$var_imp)

knn_basic_25 <- KNN_model(x_train_base, y_train_base, x_test_base, y_test_base, 25, NULL)
print(knn_basic_25$model)
print(knn_basic_25$conf_matrix)
plot(knn_basic_25$roc)
print(knn_basic_25$auc)
print(knn_basic_25$var_imp)
plot(knn_basic_25$var_imp)

knn_basic_50 <- KNN_model(x_train_base, y_train_base, x_test_base, y_test_base, 50, NULL)
knn_us_10 <- KNN_model(x_train_base, y_train_base, x_test_base, y_test_base, 10, "up")
print(knn_us_10$model)
print(knn_us_10$conf_matrix)
plot(knn_us_10$roc)
print(knn_us_10$auc)
print(knn_us_10$var_imp)
plot(knn_us_10$var_imp)

knn_us_25 <- KNN_model(x_train_base, y_train_base, x_test_base, y_test_base, 25, "up")
knn_us_50 <- KNN_model(x_train_base, y_train_base, x_test_base, y_test_base, 50, "up")




# Oversmapling
ctr_os <- trainControl(method = "cv",
                    number = 10,
                    sampling = "up")

knnModel_os <- train(
  x = x_train_base, 
  y = y_train_base,
  method = "knn",
  tuneLength = 10,
  trControl = ctr_os
)

# model summary 
print(knnModel_os)
plot(knnModel_os)

# predict on test set 

pred_os <- predict(knnModel_os, newdata = x_test_base)

# evaluate performance

conf_matrix_os <- confusionMatrix(pred_os, y_test_base)
print(conf_matrix_os)

# This still gives the same problem 

# Smote 


# function for training knn model 
