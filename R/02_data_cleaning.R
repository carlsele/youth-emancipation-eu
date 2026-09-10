# Cleaning each dataset
library(tidyverse)

# Dataset 1
yth_demo_030 <- yth_demo_030 %>% 
  filter(!geo %in% c("EU27_2020", "EA21"), sex == "T") %>%
  mutate(TIME_PERIOD = year(TIME_PERIOD),
         age_leaving_home = values) %>%
  select(geo, TIME_PERIOD, age_leaving_home)

# Dataset 2
yth_empl_100 <- yth_empl_100 %>% 
  filter(!geo %in% c("EU27_2020", "EA21"),
         c_birth %in% c("NAT", "EU27_2020_FOR", "NEU27_2020_FOR"),
         sex == "T",
         age == "Y15-29",
         !is.na(values)) %>%
  mutate(TIME_PERIOD = year(TIME_PERIOD),
         youth_unemp_rate = values) %>%
  select(c_birth, geo, TIME_PERIOD, youth_unemp_rate) %>% 
  pivot_wider(names_from = c_birth, values_from = youth_unemp_rate, 
              names_prefix = "unemp_") %>%
  filter(!is.na(unemp_NAT), 
         !is.na(unemp_EU27_2020_FOR), 
         !is.na(unemp_NEU27_2020_FOR))

# Dataset 3
ilc_di03 <- ilc_di03 %>% 
  filter(!geo %in% c("EU", "EU15", "EU28", "EA", "EA18","EA19", "EA20", 
                     "EA21", "EU27_2007", "EU27_2020"),
         sex == "T",
         age == "TOTAL",
         unit == "PPS",
         statinfo == "MED_EI",
         !is.na(values)) %>%
  mutate(TIME_PERIOD = year(TIME_PERIOD),
         median_income = values) %>%
  select(geo, TIME_PERIOD, median_income)

# Dataset 4
ilc_li02 <- ilc_li02 %>% 
  filter(!geo %in% c("EU", "EA21", "EU27_2020"),
         sex == "T",
         age == "TOTAL",
         unit == "PC",
         statinfo == "MED_EI",
         rskpovth == "B_60",
         !is.na(values)) %>%
  mutate(TIME_PERIOD = year(TIME_PERIOD),
         at_risk_pov_rate = values) %>%
  select(geo, TIME_PERIOD, at_risk_pov_rate)

# Dataset 5
ilc_lvho07a <- ilc_lvho07a %>%
  filter(!geo %in% c("EU", "EU15", "EU28", "EA", "EA18", "EA19", "EA20", 
                     "EA21", "EU27_2007", "EU27_2020"),
         sex == "T",
         age == "TOTAL",
         rskpovth == "B_60",
         !is.na(values)) %>%
  mutate(TIME_PERIOD = year(TIME_PERIOD), 
         housing_cost_overburden = values) %>%
  select(geo, TIME_PERIOD, housing_cost_overburden)

# Dataset 6
edat_lfse_03 <- edat_lfse_03 %>%
  filter(!geo %in% c("EA21", "EU27_2020"),
         sex == "T",
         age == "Y15-29",
         isced11 %in% c("ED0-2", "ED3_4", "ED5-8"),
         !is.na(values)) %>%
  mutate(TIME_PERIOD = year(TIME_PERIOD), 
         pop = values) %>%
  select(geo, TIME_PERIOD, isced11, pop) %>%
  pivot_wider(names_from = isced11, values_from = pop,
              names_prefix = "edu_")

# Dataset 7
nama_10_pc <- nama_10_pc %>%
  filter(!geo %in% c("EA", "EA12", "EA19", "EA20", "EA21", "EU27_2020"),
         na_item == "B1GQ",
         unit == "CP_PPS_EU27_2020_HAB",
         !is.na(values)) %>%
  mutate(TIME_PERIOD = year(TIME_PERIOD), 
         gdp_per_capita = values) %>%
  select(geo, TIME_PERIOD, gdp_per_capita)

# Dataset 8
edat_lfse_20 <- edat_lfse_20 %>%
  filter(!geo %in% c("EA21", "EU27_2020"),
         sex == "T",
         age == "Y15-29",
         wstatus == "NEMP",
         !is.na(values)) %>%
  mutate(TIME_PERIOD = year(TIME_PERIOD), 
         neet_rate = values) %>%
  select(geo, TIME_PERIOD, neet_rate)
