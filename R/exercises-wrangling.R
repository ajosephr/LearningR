# Load the packages
source(here::here("R/package-loading.R"))

# Check column names
colnames(NHANES)

# Look at contents
str(NHANES)
glimpse(NHANES)

# See summary
summary(NHANES)

# Look over the dataset documentation
?NHANES

# select one column by name
select(NHANES, Age)
select(NHANES, Age, Weight, BMI)
#exclude a column
select(NHANES, -HeadCirc)
#All columns starting with "BP"
select(NHANES, starts_with("BP"))

# All columns ending with "Day"
select(NHANES, ends_with("Day"))
#All columns that contain age
select(NHANES, contains("Age"))
?select_helpers

#save the selected columns as a new data frame
nhanes_small <- select(NHANES, Age, Gender, Height, Weight, BMI, Diabetes, DiabetesAge,
                       PhysActiveDays, PhysActive, TotChol, BPSysAve, BPDiaAve, SmokeNow, Poverty)
#view the new data frame
nhames_small
nhanes_small

## Renaming
# Rename all columns to snakecase
nhanes_small <- rename_with(nhanes_small, snakecase::to_snake_case)
nhanes_small

#Renaming specific columns
rename(nhanes_small, sex = gender)

nhanes_small

nhanes_small <- rename(nhanes_small, sex = gender)

## The pipe operator

#without the pipe operator
colnames(nhanes_small)
# Pipe operator: Cmd + Shift + M
nhanes_small %>% colnames()

# using pipe operator with more functions

nhanes_small %>%
    select(phys_active) %>%
    rename(physically_active = phys_active)
