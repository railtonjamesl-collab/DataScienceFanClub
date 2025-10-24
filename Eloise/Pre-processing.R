library(dplyr)

bankruptcy_data <- read.csv("C:/Users/elois/OneDrive/Documents/University of Bristol/Semester 1/Data Science Toolbox/Assessments/Assessment 1/american_bankruptcy.csv")

length(unique(bankruptcy_data$company_name))

# 8,791 companies total

failed_comp_total <- bankruptcy_data %>% 
  filter(status_label == "failed")

length(unique(failed_comp_total$company_name))

# 609 bankrupt companies

# Finding how many companies have missing yearsin between recorded years

company_list <- data.frame(company = unique(bankruptcy_data$company_name))

broken_rec_comp <- c()

for (i in 1:length(company_list$company)) {
  company <- bankruptcy_data %>%
    filter(company_name == company_list$company[i]) %>%
    arrange(year)  # ascending order, oldest to newest
  
  consec_yrs <- 0
  
  if (nrow(company) > 1) {  # only check if there’s more than one year
    for (j in 2:nrow(company)) {
      if (company$year[j] == company$year[j - 1] + 1) {
        consec_yrs <- consec_yrs + 1
      } else {
        broken_rec_comp <- append(broken_rec_comp, company$company_name[j])
      }
    }
  }
  rm(company)
}

broken_rec_comp_df <- as.list(broken_rec_comp)

length(unique(broken_rec_comp))

# 710

# remove these companies from the data 

data_rm_br <- bankruptcy_data %>%
  filter(!company_name %in% broken_rec_comp)

length(unique(data_rm_br$company_name))

# 8,261 companies total

failed_comp_2 <- data_rm_br %>% 
  filter(status_label == "failed")

length(unique(failed_comp_2$company_name))

# 561 bankrupt companies

# Filter to companies that have at least 3 years of records

recs_gt_three_yrs <- data_rm_br %>% 
  group_by(company_name) %>% 
  filter(n_distinct(year) >= 3)  %>%
  mutate(first_year_rec = min(year),
         last_year_rec = max(year),
         number_years_rec = last_year_rec - first_year_rec) %>%
  ungroup()

length(unique(recs_gt_three_yrs$company_name))

# 6,635 companies left

failed_comp_3yr <- recs_gt_three_yrs %>%
  filter(status_label == "failed")

length(unique(failed_comp_3yr$company_name))

# 529 bankrupt companies

# Change Status label

status_label_change <- recs_gt_three_yrs %>% 
  mutate(status_label_1yr = case_when(status_label == "failed" & year != last_year_rec ~ "alive",
                                      status_label == "failed" & year == last_year_rec ~ "failed",
                                      status_label == "alive" ~ "alive"),
         status_label_2yr = case_when(status_label == "failed" & year != last_year_rec & year != last_year_rec - 1 ~ "alive",
                                      status_label == "failed" & (year == last_year_rec | year == last_year_rec - 1) ~ "failed",
                                      status_label == "alive" ~ "alive"),
         status_label_3yr = case_when(status_label == "failed" & year != last_year_rec & year != last_year_rec - 1 & year != last_year_rec - 2 ~ "alive",
                                      status_label == "failed" & (year == last_year_rec | year == last_year_rec - 1 | year == last_year_rec - 2) ~ "failed",
                                      status_label == "alive" ~ "alive"))

status_label_change %>% 
  count(status_label_1yr) 

# 529 companies bankrupt - same as before 

status_label_change %>% 
  count(status_label_2yr)

# 1058 flagged as failed (2*529)

status_label_change %>% 
  count(status_label_3yr)

# 1587 flaggd as failed (3*529)

# Add in lagged variables

# ask chatgpt 
# I have a data frame with panel data in it. there is a few thousand companies. each company has several observations, one per year. All the companies have data for some consecutive years between 1999 and 2018 but not necessarily this whole period. For each observation I want to add extra columns containing the same variables but from the previous three years e.g. columns would be company_name, year, status_lable, X1, X2, X3, X4, ...., X1_1yr, X2_1yr, ......, X1_2yr, X2_2yr, ....., X1_3yr,, X2_3yr, ....., how would i do this?


data_with_lag <-  status_label_change %>%
  arrange(company_name, year) %>%              # make sure it’s ordered
  group_by(company_name) %>%                   # do lags within each company
  mutate(
    across(
      c(X1, X2, X3, X4, X5, X6, X7, X8, X9, X10, X11, X12, X13, X14, X15, X16, X17, X18),                           # variables to lag
      list(
        `1yr` = ~lag(.x, 1),
        `2yr` = ~lag(.x, 2),
        `3yr` = ~lag(.x, 3)
      ),
      .names = "{.col}_{.fn}"                  # naming pattern
    )
  ) %>%
  ungroup()

# Rearrange data 

data_full <- data_with_lag %>% 
  select(-status_label, -first_year_rec, -last_year_rec, -number_years_rec) %>%
  relocate(status_label_1yr, .after = year) %>%
  relocate(status_label_2yr, .after = status_label_1yr) %>%
  relocate(status_label_3yr, .after = status_label_2yr)

# Take out observations with NAs

data_na_rm <- na.omit(data_full)

filepath = file.path()

write.csv(bankcruptcy_data, "C:/Users/elois/OneDrive/Documents/University of Bristol/Semester 1/Data Science Toolbox/Assessments/Assessment 1/DataScienceFanClub/Data/raw_data.csv")

write.csv(data_full, "C:/Users/elois/OneDrive/Documents/University of Bristol/Semester 1/Data Science Toolbox/Assessments/Assessment 1/DataScienceFanClub/Data/preprocessed_data_full.csv")

write.csv(data_na_rm, "C:/Users/elois/OneDrive/Documents/University of Bristol/Semester 1/Data Science Toolbox/Assessments/Assessment 1/DataScienceFanClub/Data/preprocessed_data.csv")
