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

# write to csv
write_csv(econ_analysis, "inputs/data/econ_analysis.csv")
write_csv(sipp_analysis, "inputs/data/sipp_analysis.csv")
write_csv(nlsy_analysis, "inputs/data/nlsy_analysis.csv")
write_csv(nlsy_state_variables, "inputs/data/nlsy_state_variables.csv")
write_csv(hpi_analysis, "inputs/data/hpi_analysis.csv")