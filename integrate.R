##  Project Name:  CoralNet AI Threshold Experiment
##
##  Objective:     Assess how changing the confidence threshold within CoralNet
##                 affects the AI's accuarcy and the time it takes the user to
##                 complete photo analysis 
##
##  Approach:      1. Create individual sources on CoralNet for each
##                    threshold level that I want to try (300 trainer photos & 
##                    50 experimental photos; all from Asan's B Cluster) 
##                 2. Analyze photos within CoralNet for each threshold level
##                   - time to analyze photo
##                   - number of pre-confirmed annotations
##                   - accuracy of AI for each picture
##                 3. Analyze photo results (i.e., do statistics) withinn this 
##                    project
##
##  Authors:       Marisa Agarwal (War in the Pacific NHP)
##
##  Start Date:    2022-03-03
##

##  Notes:         RUN THIS FILE BEFORE EVERY SESSION 


##  1. point to working directory

setwd("research/WAPA_AIthreshold_experiment")



##  2. Set up core functionality

# clean up
rm(list=ls())

# call to core packages for data manipulation
library(dplyr)
library(tidyr)
library(magrittr)      
library(purrr)
library(lubridate)
library(stringr)
library(forcats)      
library(tidyverse)
library(see)
library(broom)

# for importing different formats
library(readr)
library(readxl)

# for easier tidy stats 
library(rstatix)
library(easystats)
library(multcomp)
library(vegan)

# call to visualisation & output generation
library(ggplot2)
library(GGally)
library(Cairo)
library(extrafont)
library(RColorBrewer)
library(viridis)
library(ggdist)
library(ggsci)
library(plotrix)
library(multcompView)
library(ggpubr)

# # set font for graphical outputs
# theme_set(theme_bw(base_family = "Helvetica"))
# CairoFonts(  # slight mod to example in ?CairoFonts page
# regular    = "Helvetica:style = Regular",
# bold       = "Helvetica:style = Bold",
# italic     = "Helvetica:style = Oblique",
# bolditalic = "Helvetica:style = BoldOblique"
# )

# # call to map theme
# source("R/theme_nothing.R")


## 2. Generate core data objects
## if things need to be loaded in before every session, include them here





