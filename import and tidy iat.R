## Race IAT Analyses | Group Processes Lab
## IMPORT AND TIDY


# strategy (updated: 2018-08-06)
# (1) import, combine, tidy iat data from 2002/2003-2013
# (3) import, combine census data

# {setup} -----------------------------------------------------------------

require(tidyverse)  # for data tidying

require(haven)     # package for importing SPSS .sav files directly
# import .sav (SPSS) file from zipped folder
# source: https://stat.ethz.ch/R-manual/R-devel/library/utils/html/unzip.html
# source: http://www.statscanbefun.com/rblog/2015/8/26/reading-spss-data-into-r

require(beepr)    # to play sound upon completion of import
require(here)


# 2002-2003 ---------------------------------------------------------------

# unzip folder, import .sav
raw <- read_spss(unzip("Race_IAT.public.2002-2003.zip", 
                       files = "Race IAT.public.2002-2003.sav"))

# tidy and select vars
data02 <- raw %>% 
  filter(!is.na(D_biep.White_Good_all)) %>%  # exclude missing IAT scores    
  filter(!is.na(ethnic)) %>%                 # exclude missing ethnicity
  filter(CountyNo != "") %>%                 # exclude missing county numbers
  filter(pct_300 < 10) %>%                   # error rate / RT exclusions
  filter((pct_4K < 5) & 
           (PCT_error_3467 < 35) &
           (Mn_RT_all_3467 < 2500)) %>% 
    select(                                  # select variables of interest
    iat = D_biep.White_Good_all, 
    therm.blacks = tblacks_0to10, 
    therm.whites = twhites_0to10, 
    att_5, 
    session.id = session_id, 
    num, 
    age, 
    ethnic, 
    gender = sex, 
    edu = edu_9, 
    country, 
    state = STATE, 
    county.no = CountyNo, 
    msa.no = MSANo, 
    msa.name = MSAName, 
    year)

# remove raw data from working memory
rm(raw)  

# delete unzipped .sav file
file.remove("Race IAT.public.2002-2003.sav")

# completion sound
beep(2)


# 2004 --------------------------------------------------------------------


# unzip folder, import .sav
raw <- read_spss(unzip("Race_IAT.public.2004.zip", 
                       files = "Race IAT.public.2004.sav"))

# tidy and select vars
data04 <- raw %>% 
  filter(!is.na(D_biep.White_Good_all)) %>%  # exclude missing IAT scores    
  filter(!is.na(ethnic)) %>%                 # exclude missing ethnicity
  filter(CountyNo != "") %>%                 # exclude missing county numbers
  filter(pct_300 < 10) %>%                   # error rate / RT exclusions
  filter((pct_4K < 5) & 
           (PCT_error_3467 < 35) &
           (Mn_RT_all_3467 < 2500)) %>% 
  select(
    iat = D_biep.White_Good_all, 
    therm.blacks = tblacks_0to10, 
    therm.whites = twhites_0to10, 
    att_5, 
    politicalid_6, 
    session.id = session_id, 
    num, 
    age, 
    ethnic, 
    gender = sex, 
    edu = edu_14, 
    country = countrycit, 
    state = STATE, 
    county.no = CountyNo, 
    msa.no = MSANo, 
    msa.name = MSAName, 
    year)

# remove raw data from working memory
rm(raw)  

# delete unzipped .sav file
file.remove("Race IAT.public.2004.sav")

# completion sound
beep(2)

# 2005 --------------------------------------------------------------------

# unzip folder, import .sav
raw <- read_spss(unzip("Race_IAT.public.2005.zip", 
                       files = "Race IAT.public.2005.sav"))

# tidy and select vars
data05 <- raw %>% 
  filter(!is.na(D_biep.White_Good_all)) %>%  # exclude missing IAT scores    
  filter(!is.na(ethnic)) %>%                 # exclude missing ethnicity
  filter(CountyNo != "") %>%                 # exclude missing county numbers
  filter(pct_300 < 10) %>%                   # error rate / RT exclusions
  filter((pct_4K < 5) & 
           (PCT_error_3467 < 35) &
           (Mn_RT_all_3467 < 2500)) %>% 
  select(
    iat = D_biep.White_Good_all, 
    therm.blacks = tblacks_0to10, 
    therm.whites = twhites_0to10, 
    att_5, 
    politicalid_6, 
    session.id = session_id, 
    num, 
    age, 
    ethnic, 
    gender = sex, 
    edu = edu_14, 
    country = countrycit, 
    state = STATE, 
    county.no = CountyNo, 
    msa.no = MSANo, 
    msa.name = MSAName, 
    year)

# remove raw data from working memory
rm(raw)  
# delete unzipped .sav file
file.remove("Race IAT.public.2005.sav")

# completion sound
beep(2)

# 2006 --------------------------------------------------------------------

# unzip folder, import .sav
raw <- read_spss(unzip("Race_IAT.public.2006.zip", 
                       files = "Race IAT.public.2006.sav"))


# select only rows with complete IAT score, ethnicity, gender, location
data06 <- raw %>% 
  filter(!is.na(D_biep.White_Good_all)) %>%  # exclude missing IAT scores    
  filter(!is.na(ethnic)) %>%                 # exclude missing ethnicity
  filter(CountyNo != "") %>%                 # exclude missing county numbers
  filter(pct_300 < 10) %>%                   # error rate / RT exclusions
  filter((pct_4K < 5) & 
           (PCT_error_3467 < 35) &
           (Mn_RT_all_3467 < 2500)) %>% 
  select(
    iat = D_biep.White_Good_all, 
    therm.blacks = tblacks_0to10,
    therm.blacks2 = tblack_0to10, 
    therm.whites = twhites_0to10, 
    therm.whites2 = twhite_0to10, 
    att_5, 
    att_7, 
    politicalid_6, 
    politicalid_7, 
    session.id = session_id, 
    num, 
    age, 
    ethnic, 
    gender = sex, 
    edu = edu_14, 
    country = countrycit, 
    state = STATE, 
    county.no = CountyNo, 
    msa.no = MSANo, 
    msa.name = MSAName, 
    year)

# concatenate therm_blacks+therm_blacks2 and therm_whites+therm_whites2
# same scale, but _blacks2 and _whites2 started in 9/2006
# source: https://stackoverflow.com/questions/29634425/merging-two-columns-into-one-in-r
data06$therm.blacks <- coalesce(data06$therm.blacks, data06$therm.blacks2)
data06$therm.whites <- coalesce(data06$therm.whites, data06$therm.whites2)

# remove superfluous therm variables
data06 <- data06 %>% 
  select(-therm.blacks2, 
         -therm.whites2)

# remove raw data from working memory
rm(raw) 

# delete unzipped .sav file
file.remove("Race IAT.public.2006.sav")

# completion sound
beep(2)

# 2007 --------------------------------------------------------------------

# unzip folder, import .sav
raw <- read_spss(unzip("Race_IAT.public.2007.zip", 
                       files = "Race IAT.public.2007.sav"))


# select only rows with complete IAT score, ethnicity, gender, location
data07 <- raw %>% 
  filter(!is.na(D_biep.White_Good_all)) %>%  # exclude missing IAT scores    
  filter(!is.na(raceomb)) %>%                # exclude missing ethnicity
  filter(CountyNo != "") %>%                 # exclude missing county numbers
  filter(pct_300 < 10) %>%                   # error rate / RT exclusions
  filter((pct_4K < 5) & 
           (PCT_error_3467 < 35) &
           (Mn_RT_all_3467 < 2500)) %>% 
  select(
    iat = D_biep.White_Good_all, 
    therm.blacks = tblack_0to10,
    therm.whites = twhite_0to10, 
    att_7, 
    politicalid_7, 
    session.id = session_id, 
    num, 
    age, 
    raceomb, 
    gender = sex, 
    edu = edu_14, 
    country = countrycit, 
    state = STATE, 
    county.no = CountyNo, 
    msa.no = MSANo, 
    msa.name = MSAName, 
    year)

# remove raw data from working memory
rm(raw)  
# delete unzipped .sav file
file.remove("Race IAT.public.2007.sav")

# completion sound
beep(2)


# 2008 --------------------------------------------------------------------

# unzip folder, import .sav
raw <- read_spss(unzip("Race_IAT.public.2008.zip", 
                       files = "Race IAT.public.2008.sav"))


# select only rows with complete IAT score, ethnicity, gender, location
data08 <- raw %>% 
  filter(!is.na(D_biep.White_Good_all)) %>%  # exclude missing IAT scores    
  filter(!is.na(raceomb)) %>%                # exclude missing ethnicity
  filter(CountyNo != "") %>%                 # exclude missing county numbers
  filter(pct_300 < 10) %>%                   # error rate / RT exclusions
  filter((pct_4K < 5) & 
           (PCT_error_3467 < 35) &
           (Mn_RT_all_3467 < 2500)) %>% 
  select(
    iat = D_biep.White_Good_all, 
    therm.blacks = tblack_0to10,
    therm.whites = twhite_0to10, 
    att_7, 
    politicalid_7, 
    session.id = session_id, 
    num, 
    age, 
    raceomb, 
    gender = sex, 
    edu = edu_14, 
    country = countrycit, 
    state = STATE, 
    county.no = CountyNo, 
    msa.no = MSANo, 
    msa.name = MSAName, 
    year)

# remove raw data from working memory
rm(raw)  
# delete unzipped .sav file
file.remove("Race IAT.public.2008.sav")

# completion sound
beep(2)

# 2009 --------------------------------------------------------------------

# unzip folder, import .sav
raw <- read_spss(unzip("Race_IAT.public.2009.zip", 
                       files = "Race IAT.public.2009.sav"))


# select only rows with complete IAT score, ethnicity, gender, location
data09 <- raw %>% 
  filter(!is.na(D_biep.White_Good_all)) %>%  # exclude missing IAT scores    
  filter(!is.na(raceomb)) %>%                # exclude missing ethnicity
  filter(CountyNo != "") %>%                 # exclude missing county numbers
  filter(pct_300 < 10) %>%                   # error rate / RT exclusions
  filter((pct_4K < 5) & 
           (PCT_error_3467 < 35) &
           (Mn_RT_all_3467 < 2500)) %>% 
  select(
    iat = D_biep.White_Good_all, 
    therm.blacks = tblack_0to10,
    therm.whites = twhite_0to10, 
    att_7, 
    politicalid_7, 
    session.id = session_id, 
    num, 
    age, 
    raceomb, 
    gender = sex, 
    edu = edu_14, 
    country = countrycit, 
    state = STATE, 
    county.no = CountyNo, 
    msa.no = MSANo, 
    msa.name = MSAName, 
    year)

# remove raw data from working memory
rm(raw)  
# delete unzipped .sav file
file.remove("Race IAT.public.2009.sav")

# completion sound
beep(2)

# 2010 --------------------------------------------------------------------

# unzip folder, import .sav
raw <- read_spss(unzip("Race_IAT.public.2010.zip", 
                       files = "Race IAT.public.2010.sav"))


# select only rows with complete IAT score, ethnicity, gender, location
data10 <- raw %>% 
  filter(!is.na(D_biep.White_Good_all)) %>%  # exclude missing IAT scores    
  filter(!is.na(raceomb)) %>%                # exclude missing ethnicity
  filter(CountyNo != "") %>%                 # exclude missing county numbers
  filter(pct_300 < 10) %>%                   # error rate / RT exclusions
  filter((pct_4K < 5) & 
           (PCT_error_3467 < 35) &
           (Mn_RT_all_3467 < 2500)) %>% 
  select(
    iat = D_biep.White_Good_all, 
    therm.blacks = tblack_0to10,
    therm.whites = twhite_0to10, 
    att_7, 
    politicalid_7, 
    session.id = session_id, 
    num, 
    age, 
    raceomb, 
    gender = sex, 
    edu = edu_14, 
    country = countrycit, 
    state = STATE, 
    county.no = CountyNo, 
    msa.no = MSANo, 
    msa.name = MSAName, 
    year)

# remove raw data from working memory
#rm(raw)  
# delete unzipped .sav file
file.remove("Race IAT.public.2010.sav")

# completion sound
beep(2)

# 2011 --------------------------------------------------------------------

# unzip folder, import .sav
raw <- read_spss(unzip("Race_IAT.public.2011.zip", 
                       files = "Race IAT.public.2011.sav"))


# select only rows with complete IAT score, ethnicity, gender, location
data11 <- raw %>% 
  filter(!is.na(D_biep.White_Good_all)) %>%  # exclude missing IAT scores    
  filter(!is.na(raceomb)) %>%                # exclude missing ethnicity
  filter(CountyNo != "") %>%                 # exclude missing county numbers
  filter(pct_300 < 10) %>%                   # error rate / RT exclusions
  filter((pct_4K < 5) & 
           (PCT_error_3467 < 35) &
           (Mn_RT_all_3467 < 2500)) %>% 
  select(
    iat = D_biep.White_Good_all, 
    therm.blacks = tblack_0to10,
    therm.whites = twhite_0to10, 
    att_7, 
    politicalid_7, 
    session.id = session_id, 
    num, 
    age, 
    raceomb, 
    gender = sex, 
    edu = edu_14, 
    country = countrycit, 
    state = STATE, 
    county.no = CountyNo, 
    msa.no = MSANo, 
    msa.name = MSAName, 
    year)

# remove raw data from working memory
rm(raw)  
# delete unzipped .sav file
file.remove("Race IAT.public.2011.sav")

# completion sound
beep(2)

# 2012 --------------------------------------------------------------------

# unzip folder, import .sav
raw <- read_spss(unzip("Race_IAT.public.2012.zip", 
                       files = "Race IAT.public.2012.sav"))


# select only rows with complete IAT score, ethnicity, gender, location
data12 <- raw %>% 
  filter(!is.na(D_biep.White_Good_all)) %>%  # exclude missing IAT scores    
  filter(!is.na(raceomb)) %>%                # exclude missing ethnicity
  filter(CountyNo != "") %>%                 # exclude missing county numbers
  filter(pct_300 < 10) %>%                   # error rate / RT exclusions
  filter((pct_4K < 5) & 
           (PCT_error_3467 < 35) &
           (Mn_RT_all_3467 < 2500)) %>% 
  select(
    iat = D_biep.White_Good_all, 
    therm.blacks = tblack_0to10,
    therm.whites = twhite_0to10, 
    att_7, 
    politicalid_7, 
    session.id = session_id, 
    num, 
    age, 
    raceomb, 
    gender = sex, 
    edu = edu_14, 
    country = countrycit, 
    state = STATE, 
    county.no = CountyNo, 
    msa.no = MSANo, 
    msa.name = MSAName, 
    year)

# remove raw data from working memory
rm(raw)  
# delete unzipped .sav file
file.remove("Race IAT.public.2012.sav")

# completion sound
beep(2)

# 2013 --------------------------------------------------------------------

# unzip folder, import .sav
raw <- read_spss(unzip("Race_IAT.public.2013.zip", 
                       files = "Race IAT.public.2013.sav"))


# select only rows with complete IAT score, ethnicity, gender, location
data13 <- raw %>% 
  filter(!is.na(D_biep.White_Good_all)) %>%  # exclude missing IAT scores    
  filter(!is.na(raceomb)) %>%                # exclude missing ethnicity
  filter(CountyNo != "") %>%                 # exclude missing county numbers
  filter(pct_300 < 10) %>%                   # error rate / RT exclusions
  filter((pct_4K < 5) & 
           (PCT_error_3467 < 35) &
           (Mn_RT_all_3467 < 2500)) %>% 
  select(
    iat = D_biep.White_Good_all, 
    therm.blacks = tblack_0to10,
    therm.whites = twhite_0to10, 
    att_7, 
    politicalid_7, 
    session.id = session_id, 
    num, 
    age, 
    raceomb, 
    gender = sex, 
    edu = edu_14, 
    country = countrycit, 
    state = STATE, 
    county.no = CountyNo, 
    msa.no = MSANo, 
    msa.name = MSAName, 
    year)

# remove raw data from working memory
rm(raw)  
# delete unzipped .sav file
file.remove("Race IAT.public.2013.sav")


# completion sound
beep(2)



# merge years and recode variables ----------------------------------------

# merge 2002-2013
# source: https://dplyr.tidyverse.org/reference/bind.html
data.iat <- bind_rows(data02, 
                  data04, 
                  data05, 
                  data06, 
                  data07, 
                  data08, 
                  data09, 
                  data10, 
                  data11, 
                  data12, 
                  data13)


# Recode both ethnicity variables ($ethnic and $raceomb) to same scale
# as recommended by ProjectImplicit
data.iat <- data.iat %>% 
  mutate(ethnic = factor(ethnic), 
         raceomb = factor(raceomb)) %>% 
  mutate(ethnic = recode(ethnic,      # recode $ethnic
                         "1" = "0", 
                         "2" = "3",   # Asians 
                         "3" = "2",   # Blacks
                         "4" = "4",   # Hispanics
                         "5" = "1",   # Whites
                         "6" = "0", 
                         "7" = "0", 
                         "8" = "0"), 
         raceomb = recode(raceomb,    # recode $raceomb
                          "1" = "0", 
                          "2" = "3",  # Asians
                          "3" = "3",  # Asians
                          "4" = "0", 
                          "5" = "2",  # Blacks
                          "6" = "1",  # Whites
                          "7" = "0", 
                          "8" = "0", 
                          "9" = "0")) %>% 
  mutate(ethnicity = coalesce(ethnic, raceomb)) %>%   # coalesce to one variable
  mutate(ethnicity = recode(ethnicity,                # add value labels
                            "1" = "White", 
                            "2" = "Black", 
                            "3" = "Asian", 
                            "4" = "Hispanic", 
                            "0" = "Other")) %>% 
  select(-ethnic, -raceomb)                           # remove old variables


# Recode att_5 and att_7 so both are on scale from 0 to 1
# formula: new_value_0_to_1 <- (old value - min)/(max - min)
data.iat <- data.iat %>% 
  mutate(att_5 = (att_5 - 1) / 4,             # recode att_5
         att_7 = (att_7 - 1) / 6) %>%         # recode att_7
  mutate(att   = coalesce(att_5, att_7)) %>%  # coalesce both
  select(-att_5, -att_7)                      # remove old variables


# Recode politicalid_6 and politicalid_7 so both are on scale from 0 to 1

# standardize politicalid_6 and political_7
# formula: new_value_0_to_1 <- (old value - min)/(max - min)
data.iat <- data.iat %>% 
  mutate(politicalid_6 = (politicalid_6 - 1) / 5, 
         politicalid_7 = (politicalid_7 - 1) / 6) %>% 
  mutate(politicalid   = coalesce(politicalid_6, politicalid_7)) %>% 
  select(-politicalid_6, -politicalid_7)


# select only united states (e.g., not philippines)
data.iat <- data.iat %>% 
  mutate(state = factor(state)) %>% 
  mutate(country = factor(country)) %>% 
  filter(state == "AL" | state == "AK" | state == "AZ" | state == "CA" | 
           state == "CO" | state == "CT" | state == "DE" | state == "DC" | 
           state == "FL" | state == "GA" | state == "HI" | state == "ID" | 
           state == "IL" | state == "IN" | state == "IA" | state == "KS" | 
           state == "KY" | state == "LA" | state == "ME" | state == "MD" | 
           state == "MA" | state == "MI" | state == "MN" | state == "MS" | 
           state == "MO" | state == "MT" | state == "NE" | state == "NV" | 
           state == "NH" | state == "NJ" | state == "NM" | state == "NY" | 
           state == "NC" | state == "ND" | state == "OH" | state == "OK" | 
           state == "OR" | state == "PA" | state == "RI" | state == "SC" | 
           state == "SD" | state == "TN" | state == "TX" | state == "UT" | 
           state == "VT" | state == "VA" | state == "WA" | state == "WV" | 
           state == "WI" | state == "WY" | state == "AR") %>% 
  filter(country == "US")

# remove unused levels
data.iat$state <- droplevels(data.iat$state)
data.iat$country <- droplevels(data.iat$country)


# import and combined with state and county info ----------------------------------------------

# import .csv of state-level information
# contains all state abbreviations, state numbers, and lowercase state names
state_info <- read.csv("state_info.csv")

# merge state info with iat data
data.iat <- merge(data.iat, state_info,
              by = "state", 
              all = TRUE)


# concatenate state number and county no
# (required for {choroplethr} mapping package)
data.iat <- data.iat %>% 
  mutate(county_full = paste(state.no, county.no, sep = ""))

# pad state number with leading zeroes so all state nos. are 2-digit
data.iat$state.no <- str_pad(data.iat$state.no, 2, pad = "0")

# concatenate state number (padded) and coutny no
# (required for mapping using {ggplot} and {urbnmapr})
data.iat <- data.iat %>% 
  mutate(county_fips = paste(state.no, county.no, sep = ""))

beep(3)

# {export} ----------------------------------------------------------------

# re-order variables in final data set
data.iat <- data.iat %>% 
  select(state, 
         state.no, 
         state.name, 
         county.no, 
         county_full, 
         county_fips, 
         msa.no, msa.name, country, 
         year, session.id, num, 
         iat,
         therm.blacks, 
         therm.whites, 
         att, 
         politicalid, 
         age, ethnicity, gender, edu)

# remove all objects but final data set
rm(data02, data04, data05, data06, data07, data08, 
   data09, data10, data11, data12, data13, 
   state_info)

# export data.iat
write.csv(data.iat, 
          "iat_2002-2013.csv", 
          row.names = FALSE)
beep(3)
