#' [Defunct] Get a show or movie's stats
#'
#' DEFUNCT as of 2015-03-06,
#' see \href{http://docs.trakt.apiary.io/reference/shows/stats/get-show-stats}{their API docs}
#'
#' \code{trakt.stats} pulls show stats and returns it compactly.
#' The data includes show ratings, scrobbles, checkins, plays, comments…
#' @param target The \code{id} of the show/movie requested. Either the \code{slug}
#' (e.g. \code{"game-of-thrones"}), \code{trakt id} or \code{IMDb id}.
#' @param type Either \code{shows} (default) or \code{movies}, depending the \code{target} type.
#' @param extended Whether extended info should be provided.
#' Defaults to \code{"min"}, can either be \code{"min"} or \code{"full"}.
#' @return A \code{list} containing show stats
#' @export
#' @note See \href{http://docs.trakt.apiary.io/#reference/shows/stats}{the trakt API docs for further info}
#' @family show data
#' @family movie data
#' @examples
#' \dontrun{
#' get_trakt_credentials() # Set required API data/headers
#' breakingbad.stats <- trakt.stats(type = "shows", "breaking-bad")
#' }
trakt.stats <- function(target, type = "shows", extended = "min"){

  # Construct URL, make API call
  url      <- build_trakt_url(type, target, "stats", extended = extended)
  response <- trakt.api.call(url = url)

  return(response)
}
