# JOINS
# Left join, the one that we will use
final_df <- yth_demo_030 %>%
  left_join(edat_lfse_03, by = c("geo", "TIME_PERIOD")) %>%
  left_join(edat_lfse_20, by = c("geo", "TIME_PERIOD")) %>%
  left_join(ilc_di03, by = c("geo", "TIME_PERIOD")) %>%
  left_join(ilc_li02, by = c("geo", "TIME_PERIOD")) %>%
  left_join(ilc_lvho07a, by = c("geo", "TIME_PERIOD")) %>%
  left_join(nama_10_pc, by = c("geo", "TIME_PERIOD")) %>%
  left_join(yth_empl_100, by = c("geo", "TIME_PERIOD"))

# Inner join, made to compare
df_inner <- yth_demo_030 %>%
  inner_join(edat_lfse_03, by = c("geo", "TIME_PERIOD")) %>%
  inner_join(edat_lfse_20, by = c("geo", "TIME_PERIOD")) %>%
  inner_join(ilc_di03, by = c("geo", "TIME_PERIOD")) %>%
  inner_join(ilc_li02, by = c("geo", "TIME_PERIOD")) %>%
  inner_join(ilc_lvho07a, by = c("geo", "TIME_PERIOD")) %>%
  inner_join(nama_10_pc, by = c("geo", "TIME_PERIOD")) %>%
  inner_join(yth_empl_100, by = c("geo", "TIME_PERIOD"))

# countries that we lose doing the inner join
setdiff(unique(final_df$geo), unique(df_inner$geo))

# detecting and solving the NA problem
final_df %>%
  filter(geo %in% c("BA","BG","EE","HU","LT","LV","ME","NO","PL","RO","SI","SK")) %>%
  group_by(geo) %>%
  summarise(across(where(is.numeric), ~ sum(is.na(.)))) %>%
  pivot_longer(-geo, names_to = "variable", values_to = "n_na") %>%
  filter(n_na > 0) %>%
  group_by(variable) %>%
  summarise(n_countries_affected = n(), total_na = sum(n_na)) %>%
  arrange(desc(total_na))

# final dataset to train and test the model
final_df_no_birth <- final_df %>%
  select(-unemp_NAT, -unemp_EU27_2020_FOR, -unemp_NEU27_2020_FOR)
