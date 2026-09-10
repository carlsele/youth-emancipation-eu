# Predicting Youth Emancipation in Europe Using Socioeconomic and Geographic Indicators

## Overview

This project builds a predictive model of the average age at which young people leave their parental home across European countries, using publicly available socioeconomic indicators from Eurostat. The goal is to explore which factors — employment, education, income, housing costs, and poverty risk — are most strongly associated with delayed or early emancipation, and to test whether these relationships generalize across countries not seen during training.

## Data Sources

All data was retrieved from Eurostat using the [`eurostat`](https://ropengit.github.io/eurostat/) R package. The following datasets were used:

| Dataset code | Description |
|----|----|
| `yth_demo_030` | Average age of young people leaving the parental household (target variable) |
| `yth_empl_100` | Youth unemployment by country of birth *(explored, later excluded — see Methodology)* |
| `ilc_di03` | Median disposable income |
| `ilc_li02` | At-risk-of-poverty rate |
| `ilc_lvho07a` | Housing cost overburden rate |
| `edat_lfse_03` | Population by educational attainment level |
| `nama_10_pc` | GDP per capita |
| `edat_lfse_20` | NEET rate (Not in Employment, Education or Training) |

## Project Structure

```         
.
├── analysis/        # Final R Markdown report and rendered output
│   ├── youth_emancipation_eu.Rmd
│   └── youth_emancipation_eu.pdf
|
├── data/
│   └── processed/         # Cleaned and joined datasets
|       ├── df_inner.csv  # inner join of all datasets
|       ├── final_df_no_birth.R # left join of all datasets, excl. yth_empl_100
|       └── final_df.csv # left join of all datasets
|
├── figures/        # All figures
|
├── R/                     # Analysis scripts, organized by stage
│   ├── 01_data_loading.R
│   ├── 02_data_cleaning.R
│   ├── 03_joins.R
│   ├── 04_train_test_split.R
│   ├── 05_models.R
│   └── 06_ensemble.R
|
├── youth_emancipation_eu.Rproj
└── README.md
```

## Methodology

-   Data was filtered to the **Y15-29** age group (the standard EU definition of "youth"), in **PPS** (Purchasing Power Standard) or percentage units where applicable, to ensure cross-country comparability.
-   Categorical variables with multiple subgroups (country of birth, ISCED education level) were reshaped from long to wide format to avoid combinatorial row expansion when joining datasets.
-   All datasets were combined using `left_join()`, starting from the target variable dataset, to preserve country coverage and avoid the systematic geographic bias observed with `inner_join()` (which disproportionately excluded Eastern European and non-EU countries).
-   The country-of-birth unemployment breakdown (`yth_empl_100`) was ultimately excluded due to widespread missing data concentrated in specific countries, which would have reintroduced that same bias.
-   **Train/test split was performed by country**, not by row, ensuring no country appears in both sets. This tests the model's ability to generalize to countries it has never seen, rather than simply learning country-specific patterns. As a result, the `geo` variable was excluded from the models themselves.

## Models

Five modeling approaches were trained and compared using `caret`:

| Model                           | RMSE (years) |
|---------------------------------|--------------|
| Linear regression (glm)         | 2.2752       |
| Ensemble (linear models only)   | 2.2753       |
| Regularized regression (glmnet) | 2.2760       |
| Ensemble (all models)           | 2.4299       |
| Random Forest (rf)              | 2.7021       |
| K-Nearest Neighbors (kNN)       | 2.9719       |

A local regression model (`gamLoess`) was also attempted but failed to converge, likely due to the relatively high number of predictors relative to the sample size — a known limitation of loess-based methods.

## Key Findings

-   **Linear models performed best**, suggesting the relationship between the selected socioeconomic indicators and youth emancipation age is largely linear and additive.
-   **Variable importance differs notably by model type**: linear models rank `neet_rate`, income, and GDP per capita highest, while random forest highlights educational attainment and housing cost overburden as the strongest predictors — reflecting how each method measures importance differently (coefficient size vs. actual improvement in prediction accuracy across splits).
-   On average, the model predicts emancipation age within roughly two years of its true value for countries not seen during training.

## Reproducing the Analysis

1.  Clone this repository and open `youth_emancipation_eu.Rproj` in RStudio.
2.  Install required packages: `tidyverse`, `eurostat`, `caret`, `glmnet`, `gam`, `randomForest`.
3.  Run the scripts in `R/` in numerical order, or knit the full report in `analysis/youth_emancipation_eu.Rmd`.

## Author

Carlos Seguí Leyton. September 2026.

## License

The code in this repository is released under the [MIT License](LICENSE).

The data used in this project comes from [Eurostat](https://ec.europa.eu/eurostat) and is reused under the [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/) licence, in accordance with Eurostat's [copyright and reuse policy](https://ec.europa.eu/eurostat/en/help/copyright-notice). Data source: Eurostat, © European Union.
