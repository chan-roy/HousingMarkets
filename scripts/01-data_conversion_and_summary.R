#### Preamble ####
# Purpose: Convert datafiles from original paper and reproduce scripts in R
# Author: Roy Chan
# Data: 27 April 2022
# Contact: rk.chan@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to download replication data from openICPSR 
# - https://www.openicpsr.org/openicpsr/project/116160/version/V1/view?path=/openicpsr/116160/fcr:versions/V1&type=project


#### Workspace setup ####
library(haven)
library(tidyverse)

# use read_dta to read and convert .dta files to R dataframes
econ_analysis <- read_dta("inputs/data/ui_econ_analysis.dta")
sipp_analysis <- read_dta("inputs/data/ui_sipp_analysis.dta")
nlsy_analysis <- read_dta("inputs/data/ui_nlsy_analysis.dta")
nlsy_state_variables <- read_dta("inputs/data/ui_nlsy_state_variables.dta")
hpi_analysis <- read_dta("inputs/data/ui_hpi_analysis.dta")

# collect variables of interest for summary statistics

# Panel A, state characteristics
# NOTE: variable hpi_growth, home price growth, has been removed from replication data
# as it is non-public data.
panel_a <- econ_analysis %>%
  select(max_ben, wba_max_thousands, duration_max, max_ben_real, ln_max_ben, 
         max_ben_wages, ui_rr, neg_ui_rr_pct, max_ben_eb_euc, eb_euc_weeks,
         unemp_rate, ln_realgdp_percap, wages_state, cov) %>%
  pivot_longer(everything(), names_to = 'variable', values_to = 'value') %>%
  group_by(variable) %>%
  summarise(mean = mean(value, na.rm = TRUE), median = median(value, na.rm = TRUE), sd = sd(value, na.rm = TRUE))

# Panel B, household characteristics, delinquency analysis
panel_b <- sipp_analysis %>%
  select(delinq_mort, evict, ltv_win, neg_equity, thomeamt, mortgage_ui, max_ben_indiv,
         layoff, earnings_total, assets_liquid, thhtnw, educ_less_hs, educ_hs,
         educ_somecol, educ_col, educ_grad) %>%
  pivot_longer(everything(), names_to = 'variable', values_to = 'value') %>%
  group_by(variable) %>%
  summarise(mean = mean(value, na.rm = TRUE), median = median(value, na.rm = TRUE), sd = sd(value, na.rm = TRUE))

# Panel C, household characteristics, foreclosure analysis
panel_c <- nlsy_analysis %>%
  select(foreclosure, lost_home, layoff, earnings_lag, net_worth_lag, 
         ltv_win_lag, ltv_win2nd_lag, neg_equity_lag, neg_equity2nd_lag) %>%
  pivot_longer(everything(), names_to = 'variable', values_to = 'value') %>%
  group_by(variable) %>%
  summarise(mean = mean(value, na.rm = TRUE), median = median(value, na.rm = TRUE), sd = sd(value, na.rm = TRUE)) %>%
  mutate(variable = replace(variable, variable == 'layoff', 'layoff_2'))

# arrange variables in same order as original paper
all_panels <- bind_rows(panel_a, panel_b, panel_c) %>%
  arrange(factor(variable, levels = c('max_ben', 'wba_max_thousands', 'duration_max', 'max_ben_real', 'ln_max_ben', 
                                      'max_ben_wages', 'ui_rr', 'neg_ui_rr_pct', 'max_ben_eb_euc', 'eb_euc_weeks', 'unemp_rate', 'ln_realgdp_percap', 
                                      'wages_state', 'cov', 'delinq_mort', 'evict', 'ltv_win', 'neg_equity', 'thomeamt', 'mortgage_ui', 'max_ben_indiv', 'layoff', 
                                      'earnings_total', 'assets_liquid', 'thhtnw', 'educ_less_hs', 'educ_hs', 'educ_somecol', 'educ_col', 
                                      'educ_grad', 'foreclosure', 'lost_home', 'ltv_win_lag', 'ltv_win2nd_lag', 
                                      'neg_equity_lag', 'neg_equity2nd_lag', 'layoff_2', 'earnings_lag', 'net_worth_lag')))
# replace variable names with labels
all_panels$variable = c("Max Benefit ($ thousands)", "Max Weekly Benefit ($ thousands)", "Max Regular Duration (weeks)", 
                        "Real Max Benefit (2011 $ thousands)", "log of Max Benefit", "Max Benefit / wages (% of semi-annual wages)", 
                        "UI trust fund reserves (% of semi-annual wages)", "UI trust fund reserve ratio < 0 (%)", 
                        "Max EB EUC ($ thousands, 2009, N = 51)", "Max EB EUC Duration (weeks, 2009, N = 51)", "Unemployment rate (%)", 
                        "log of real GDP per capita", "Average annual wages ($ thousands)", "Union coverage (%)", 
                        "Delinquent prior 12 months (%)", "Evicted prior 12 months (%)", "Loan-to-value (%)", "Negative equity indicator (%)", 
                        "Mortgage payment ($ per month)", "Mortgage payment per week / max weekly benefit (%)", 
                        "Max Benefit per household ($ thousands)", "Layoff within household in prior 12 months (%)", "Annual earnings ($ thousands)", 
                        "Liquid financial assets ($ thousands)", "Net worth ($ millions)", "No high school diploma (%)", "High school diploma only (%)", 
                        "Some college studies (%)", "College degree (%)", "Some graduate studies (%)", "Foreclosure initiation (%)", 
                        "Foreclosure completion (%)", "Loan-to-value, main property (%, N = 6064)", "Loan-to-value, other properties (%, N = 658)", 
                        "Negative equity indicator, main property (%, N = 6483)", "Negative equity indicator, other properties (%, N = 1193)", 
                        "Layoff in prior 24 months (%)", "Annual earnings ($)", "Net worth ($)")

# write to csv
write_csv(econ_analysis, "inputs/data/econ_analysis.csv")
write_csv(sipp_analysis, "inputs/data/sipp_analysis.csv")
write_csv(nlsy_analysis, "inputs/data/nlsy_analysis.csv")
write_csv(nlsy_state_variables, "inputs/data/nlsy_state_variables.csv")
write_csv(hpi_analysis, "inputs/data/hpi_analysis.csv")
write_csv(all_panels, "inputs/data/all_panels.csv")