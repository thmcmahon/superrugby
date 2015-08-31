#' Super Rugby results.
#'
#' Results of all Super Rugby matches from 1996 - 2015.
#'
#'
#' Thanks to Kevin Lassen for meticulously collating the original database.
#'
#' @source Kevin Lassen, \url{http://www.lassen.co.nz/s14tab.php}.
#'
#' @usage
#'  data(superrugby)
#'
#' @format A data frame with sixteen variables:
#' \describe{
#'  \item{comp}{Competition name e.g. S12 for Super 12.}
#'  \item{season}{Competition year}
#'  \item{round}{Competition round}
#'  \item{date}{Fixture date}
#'  \item{time}{Fixture time. This is missing from 1996 to 2002.}
#'  \item{country, city}{Location of fixture}
#'  \item{home, away}{Home and away team names. Most super rugby teams have
#'  changed names at least once since 1996. To allow for easier analysis, the
#'  team names have been cleaned so that only current franchise names are used.
#'  } \item{home_score, away_score}{Total points of home and away teams}
#'  \item{home_tries, away_tries}{Total tries of home and away teams}
#'  \item{home_points, away_points}{Competition points for home and away teams.
#'  4 points for a win, 2 for a draw, 1 for scoring four or more tries and 1 for
#'  losing by seven points or less.}
#'  \item{result}{Fixture result}
#' }
#'
#' @examples
#' # Show the Super 12 results from Round 1 of Season 2003
#' data(superrugby)
#' superrugby[superrugby$round==1 & superrugby$season==2003,]
"superrugby"
