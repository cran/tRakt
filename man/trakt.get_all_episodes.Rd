% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/trakt.get_all_episodes.R
\name{trakt.get_all_episodes}
\alias{trakt.get_all_episodes}
\title{Get a show's episodes. All of them.}
\usage{
trakt.get_all_episodes(target, season_nums = NULL, extended = "full",
  dropunaired = TRUE)
}
\arguments{
\item{target}{The \code{id} of the show requested. Either the \code{slug}
(e.g. \code{"game-of-thrones"}), \code{trakt id} or \code{IMDb id}.}

\item{season_nums}{Vector of season numbers, e.g. \code{c(1, 2)}. If \code{NULL}, all the seasons
are pulled by calling \link{trakt.seasons.summary} to determine the number of seasons. If a
vector of length 1 is supplied, it is extended to 1:season_nums.}

\item{extended}{Use \code{full,images} to get season posters. Can be
\code{min}, \code{images}, \code{full} (default), \code{full,images}.}

\item{dropunaired}{If \code{TRUE} (default), episodes which have not aired yet are dropped.}
}
\value{
A \code{data.frame} containing episode details
}
\description{
\code{trakt.get_all_episodes} pulls detailed episode data.
Get details for a show's episodes, e.g. ratings, number of votes,
airdates, images, plot overviews…
}
\details{
This is basically just an extension of \link[tRakt]{trakt.seasons.season}, which is used in
this function to collect all the episode data.
If you only want the episode data for a single season anyway, \code{trakt.seasons.season}
is recommended, yet this function makes some additions.
The use case of this function is to quickly gather episode data of all seasons of a show.
}
\note{
This function is mainly for convenience.
}
\examples{
\dontrun{
get_trakt_credentials() # Set required API data/headers
# Manually specifiy seasons
breakingbad.episodes <- trakt.get_all_episodes("breaking-bad", season_nums = c(1, 2, 3, 4, 5))
# Get all the seasons
breakingbad.episodes <- trakt.get_all_episodes("breaking-bad")
# Get first to 3rd season
breakingbad.episodes <- trakt.get_all_episodes("breaking-bad", season_nums = 3)
}
}
\seealso{
Other show data: \code{\link{trakt.get_full_showdata}};
  \code{\link{trakt.seasons.season}};
  \code{\link{trakt.seasons.summary}};
  \code{\link{trakt.show.people}};
  \code{\link{trakt.show.ratings}};
  \code{\link{trakt.show.summary}};
  \code{\link{trakt.show.watching}};
  \code{\link{trakt.shows.popular}};
  \code{\link{trakt.shows.related}};
  \code{\link{trakt.shows.trending}};
  \code{\link{trakt.stats}}
}

