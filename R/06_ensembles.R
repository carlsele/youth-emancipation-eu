# Creating the ensemble

# Global ensemble (glm + glmnet/en + kNN + rf)
pred_ensemble <- (pred_glm + pred_en + pred_knn + pred_rf)/4
ensemble_error <- RMSE(pred_ensemble, test_set$age_leaving_home)

# Linear ensemble (glm + glmnet/en)
pred_linear <- (pred_glm + pred_en)/2
ensemble_linear_error <- RMSE(pred_linear, test_set$age_leaving_home)

# best model <=> model with minimum RMSE <=> glm
which.min(c(glm_error, 
            en_error, 
            knn_error, 
            rf_error, 
            ensemble_error, 
            ensemble_linear_error))
