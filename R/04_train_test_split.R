# Dividing the dataset in train and test sets
set.seed(1)

# 1. We take a representative value for every country (i.e.: mean)
country_avg <- final_df_no_birth %>%
  group_by(geo) %>%
  summarise(avg_target = mean(age_leaving_home, na.rm = TRUE))

# 2. We create groups/strata with that value
country_avg <- country_avg %>%
  mutate(stratum = ntile(avg_target, 4))

# 3. We show countries inside every group/stratum
test_countries <- country_avg %>%
  group_by(stratum) %>%
  slice_sample(prop = 0.15) %>%
  pull(geo)

test_set <- final_df_no_birth %>% filter(geo %in% test_countries)
train_set <- final_df_no_birth %>% filter(!geo %in% test_countries)

# comparing means so that we have similar values in both sets
mean(train_set$age_leaving_home, na.rm = TRUE)
mean(test_set$age_leaving_home, na.rm = TRUE)

# removing final NA values to fit the models
train_set <- train_set %>% drop_na() %>% select(-geo)
test_set <- test_set %>% drop_na() %>% select(-geo)

# obs: it is not the same than doing the inner join! 
# you can check it by doing:
nrow(final_df_no_birth %>% drop_na())  # what we are doing
nrow(df_inner) # inner join
nrow(final_df %>% drop_na()) # equivalent to the inner join
