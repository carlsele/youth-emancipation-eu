# Loading the library
library(eurostat)

# 1. Estimated average age of young persons leaving the parental household
yth_demo_030 <- get_eurostat("yth_demo_030")

# 2. Youth unemployment rate by country of birth
yth_empl_100 <- get_eurostat("yth_empl_100")

# 3. Mean and median income by age and sex
ilc_di03 <- get_eurostat("ilc_di03")

# 4. At-risk-of-poverty rate by poverty threshold, 
#    age and sex (EU-SILC and ECHP surveys)
ilc_li02 <- get_eurostat("ilc_li02")

# 5. Housing cost overburden rate by age, sex and poverty status
ilc_lvho07a <- get_eurostat("ilc_lvho07a")

# 6. Population in private households by educational attainment level
edat_lfse_03 <- get_eurostat("edat_lfse_03")

# 7. GDP per capita 
nama_10_pc <- get_eurostat("nama_10_pc")

# 8. Young persons neither in employment nor in education and training
#    by labour status (NEET rates)
edat_lfse_20 <- get_eurostat("edat_lfse_20")