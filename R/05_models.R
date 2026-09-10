# Training different models & comparing them
library(caret)
library(gam)
library(glmnet)
# 1. Generalized Linear Model, GLM
set.seed(1)
train_glm <- train(age_leaving_home ~ ., method = "glm", data = train_set)
pred_glm <- predict(train_glm, test_set)
glm_error <- RMSE(pred_glm, test_set$age_leaving_home)

# 2. Locally Estimated Scatterplot Smoothing Model, LOESS
set.seed(1)
train_loess <- train(age_leaving_home ~ ., 
                     method = "gamLoess", data = train_set)
# Fails to converge, too many predictors for this model!
# pred_loess <- predict(train_loess, test_set)
# loess_error <- RMSE(pred_loess, test_set$age_leaving_home)

# 3. Regularized Regression Model (Elastic Net), glmnet
set.seed(1)
train_en <- train(age_leaving_home ~ ., method = "glmnet", data = train_set)
pred_en <- predict(train_en, test_set)
en_error <- RMSE(pred_en, test_set$age_leaving_home)

# comparing variable importance between lineal models
varImp(train_glm)
ggplot(varImp(train_glm)) +
  labs(title = "Variable Importance - Generalized Linear Model (glm)")
varImp(train_en)
ggplot(varImp(train_en)) +   
  labs(title = "Variable Importance - Elastic Net (glmnet)")

# 4. K-Nearest Neighbors Model, kNN
set.seed(1)
train_knn <- train(age_leaving_home ~ ., method = "knn", 
                   data = train_set,
                   preProcess = c("center", "scale"),
                   tuneGrid = data.frame(k = seq(3, 15, 2)))
train_knn$finalModel
plot(train_knn)
pred_knn <- predict(train_knn, test_set)
knn_error <- RMSE(pred_knn, test_set$age_leaving_home)

# 5. Random Forests, rf
set.seed(1)
train_rf <- train(age_leaving_home ~ ., method = "rf", 
                  data = train_set,
                  importance = TRUE)
train_rf$finalModel
plot(train_rf$finalModel)
pred_rf <- predict(train_rf, test_set)
rf_error <- RMSE(pred_rf, test_set$age_leaving_home)
varImp(train_rf)
ggplot(varImp(train_rf)) +   
  labs(title = "Variable Importance - Random Forests (rf)")