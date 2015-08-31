library(testthat)
library(superrugby)
library(dplyr)

data("superrugby")

test_that('Data set contains the correct number of games', {
  # There have been 1785 games of super rugby:
  # * 69 each in the 10 seasons of super 12
  # * 94 each in the 5 seasons of super 14
  # * 125 each in the 5 seasons of super 15
  expect_equal(sum(table(superrugby$season)), 1785)
})

test_that('The data set has the correct number of rows', {
  # This essentially tests the same thing as test 1.
  expect_equal(dim(superrugby)[1], 1785)
})

test_that('Classes of columns are correct', {
  expect_is(superrugby$comp, 'factor')
  expect_is(superrugby$season, 'factor')
  expect_is(superrugby$round, 'factor')
  expect_is(superrugby$date, 'POSIXct')
  expect_is(superrugby$time, 'factor')
  expect_is(superrugby$country, 'factor')
  expect_is(superrugby$city, 'factor')
  expect_is(superrugby$home, 'factor')
  expect_is(superrugby$away, 'factor')
  expect_is(superrugby$home_score, 'integer')
  expect_is(superrugby$away_score, 'integer')
  expect_is(superrugby$home_tries, 'integer')
  expect_is(superrugby$away_tries, 'integer')
  expect_is(superrugby$home_points, 'integer')
  expect_is(superrugby$away_points, 'integer')
  expect_is(superrugby$result, 'factor')
})

# Some tests for results
test_that('Highlanders won the 2015 Super Rugby season', {
  expect_equal(as.character(
    superrugby$result[superrugby$season == '2015' &
                      superrugby$round == 'Final']), 'Away Win')
})

test_that('Brumbies scored 32 competition points in 1996', {
  brumbies_96 <- filter(superrugby, season == '1996',
                        home == 'Brumbies' | away == 'Brumbies')
  brumbies_home <- sum(brumbies_96$home_points[brumbies_96$home == 'Brumbies'])
  brumbies_away <- sum(brumbies_96$away_points[brumbies_96$away == 'Brumbies'])
  expect_equal(sum(brumbies_home, brumbies_away), 32)
})

test_that('Crusaders have won 7 championships', {
  # Crusaders have won all 4 championships at home, and 3 away from home
  crusaders_finals <- filter(superrugby, round == 'Final',
                             home == 'Crusaders' | away == 'Crusaders')
  home_wins <- length(
    crusaders_finals$result[crusaders_finals$home == 'Crusaders' &
                              crusaders_finals$result == 'Home Win'])

  away_wins <- length(
    crusaders_finals$result[crusaders_finals$away == 'Crusaders' &
                              crusaders_finals$result == 'Away Win'])

  expect_equal(sum(home_wins, away_wins), 7)
})

test_that('Waratahs had 58 competition points in 2014', {
  # The dataset includes points for finals matches which are not actual
  # competition points
  tahs_2014 <- filter(superrugby, season == '2014', round != 'Final',
                      round != 'Semi', round != 'Elim',
                      home == 'Waratahs' | away == 'Waratahs')
  tahs_home <- sum(tahs_2014$home_points[tahs_2014$home == 'Waratahs'])
  tahs_away <- sum(tahs_2014$away_points[tahs_2014$away == 'Waratahs'])
  expect_equal(sum(tahs_home, tahs_away), 58)
})
