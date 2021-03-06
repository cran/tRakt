% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/trakt.people.R
\name{trakt.people.movies}
\alias{trakt.people.movies}
\title{Get a single person's movie credits}
\usage{
trakt.people.movies(target, extended = "min")
}
\arguments{
\item{target}{The \code{id} of the person requested. Either the \code{slug}
(e.g. \code{"bryan-cranston"}), \code{trakt id} or \code{IMDb id}}

\item{extended}{Whether extended info should be provided.
Defaults to \code{"min"}, can either be \code{"min"} or \code{"full"}}
}
\value{
A \code{data.frame}s with person details.
}
\description{
\code{trakt.people.movies} pulls show people data.
}
\details{
Returns all movies where this person is in the cast or crew.
}
\note{
See \href{http://docs.trakt.apiary.io/reference/people/movies/get-movie-credits}{the trakt API docs for further info}
}
\examples{
\dontrun{
get_trakt_credentials() # Set required API data/headers
person <- trakt.people.movies("bryan-cranston")
}
}
\seealso{
Other people data: \code{\link{trakt.movie.people}};
  \code{\link{trakt.people.shows}};
  \code{\link{trakt.people.summary}};
  \code{\link{trakt.show.people}}
}

