library(dplyr)
library(rvest)
library(tidyr)
library(lubridate)

get_sr_table <- function(year) {
  # Downloads the results for a given year
  base_url <- 'http://www.lassen.co.nz/s14mat.php?'
  url <- paste(base_url, "year=", year, sep = "")
  table <- html(url) %>% html_nodes('table') %>% html_table(fill = TRUE)
  table[[2]] # element 2 is the actual results, the others are metadata
}

if (!file.exists('data-raw/superrugby_raw.csv')) {
  # If the dataset is not present then download for each year of the
  # professional era and save the dataset as a csv file
  superrugby_raw <- do.call(rbind, lapply(c(1996:2015), get_sr_table))
  write.csv(superrugby_raw, file = 'data-raw/superrugby_raw.csv',
            row.names = FALSE)
  rm(superrugby_raw)
}

superrugby <- read.csv('data-raw/superrugby_raw.csv')

# Tidy up the data
names(superrugby) <- tolower(names(superrugby))

# Dates
superrugby$date <- dmy(superrugby$date)
superrugby$season <- as.factor(year(superrugby$date))

# Use the IOC encoding for country
levels(superrugby$`in`) <- c('AUS', 'NZL', 'RSA')

# Reorganise and normalise merged columns
superrugby <- superrugby %>%
  tbl_df %>%
  # Normalise merged columns
  separate(col = match, into = c('home', 'away'),
           sep = ' v ', convert = TRUE) %>%
  separate(col = score, into = c('home_score', 'away_score'),
           sep = '-', convert = TRUE) %>%
  separate(col = tries, into = c('home_tries', 'away_tries'),
           sep = ':', convert = TRUE) %>%
  separate(col = points, into = c('home_points', 'away_points'),
           sep = "-", convert = TRUE) %>%
  # Reorganise and rename
  select(comp, season, round, date, time, country = `in`, city = adv, home,
         away, home_score, away_score, home_tries, away_tries, home_points,
         away_points)

# Add a results column
superrugby$result <-
  ifelse(superrugby$home_score == superrugby$away_score, 'Draw',
         ifelse(superrugby$home_score > superrugby$away_score, 'Home Win',
                'Away Win')
         )

superrugby$result <- as.factor(superrugby$result)

save(superrugby, file = 'data/superrugby.rdata', compress = "xz")
