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

nhanes_small %>%
    select(tot_chol, bp_sys_ave, poverty)
nhanes_small %>%
    rename(diabetes_diagnosis_age = diabetes_age)

nhanes_small %>%
    select(bmi, contains("Age"))


nhanes_small %>%
    select(phys_active_days,phys_active) %>%
    rename(days_phys_active = phys_active_days)

## filtering
# filter for all females
nhanes_small %>%
    filter(sex == "female")
# participants who are not female
nhanes_small %>%
    filter(sex != "female")
#participants who have BMI equal to 25
nhanes_small %>%
    filter(bmi == 25)
#participants who have BMI greater than and equal to  25
nhanes_small %>%
    filter(bmi >= 25)
#participants who have BMI greater than 25 and sex is female
nhanes_small %>%
    filter(bmi > 25 & sex == "female")
#BMI is greater than 25 OR sex is female
nhanes_small %>%
    filter(bmi >25 | sex == "female")
## Arranging data
# Arranging by age in ascending order
nhanes_small %>%
    arrange(age)
#Arranging by sex in ascending order
nhanes_small %>%
    arrange(sex)
# Arranging by sex in descending order
nhanes_small %>%
    arrange(desc(age))
# Arranging by sex, then age in ascending order
nhanes_small %>%
    arrange(sex,age)
nhanes_small %>%
    arrange(desc(sex),age)
## Transform or add columns

nhanes_small %>%
    mutate(height = height / 100)
#Add a new column with logged height values

nhanes_small %>%
    mutate(logged_height = log(height))
# transform height values to meters and add log column
nhanes_small %>%
    mutate(height = height / 100,
           logged_height = log(height))

# transform physical activity days more than 5 to highly active
nhanes_small %>%
    mutate(highly_active = if_else(phys_active_days >= 5, "Yes", "No"))

nhanes_update <- nhanes_small %>%
    mutate(height = height / 100,
           logged_height = log(height),
           highly_active = if_else(phys_active_days >= 5, "Yes", "No"))
str(nhanes_update)

##Summary statistics by group

nhanes_small %>%
    summarise(max_bmi = max(bmi))

nhanes_small %>%
    summarise(max_bmi = max(bmi, na.rm = TRUE))
# find out how many missing values (NAs) are there
nhanes_small %>%
    summarise(sum_na = sum(is.na(bmi)))

#calculating 2 summary statistics
nhanes_small %>%
    summarise(max_bmi = max(bmi, na.rm = TRUE),
              min_bmi = min(bmi, na.rm = TRUE))






