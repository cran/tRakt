% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/api.R
\name{get_trakt_credentials}
\alias{get_trakt_credentials}
\title{Set the required trakt.tv API credentials}
\usage{
get_trakt_credentials(username = NULL, client.id = NULL,
  client.secret = NULL, set.headers = TRUE, silent = TRUE)
}
\arguments{
\item{username}{Explicitly set your trakt.tv username (Not used yet)}

\item{client.id}{Explicitly set your APIv2 client id}

\item{client.secret}{Explicitly set your APIv2 client secret}

\item{set.headers}{\code{TRUE} by default. Sets the \code{httr} headers
for \code{GET} requests for the APIv2}

\item{silent}{If TRUE (default), no messages are printed showing you the API information.
Mostly for debug purposes.}
}
\value{
Nothing. Only messages.
}
\description{
\code{get_trakt_credentials} searches for your credentials and stores them
in the appropriate \code{option} variables.
It also sets the HTTP header required for v2 API calls.
To make this work automatically, place a \code{key.json} file either in the working directory
or in \code{~/.config/trakt/key.json}.
Arguments to this function take precedence over any key file.
}
\note{
Please note that no oauth2 methods are supported yet,
only client id really matters.
}
\examples{
\dontrun{
# Use a key.json
get_trakt_credentials()

# Explicitly set values
get_trakt_credentials(username = "sean",
client.id = "12fc1de7671c7f2fb4a8ac08ba7c9f45b447f4d5bad5e11e3490823d629afdf2")
}
}
\seealso{
Other API-basics: \code{\link{trakt.api.call}};
  \code{\link{trakt.search.byid}};
  \code{\link{trakt.search}}
}

