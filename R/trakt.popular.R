#' Get popular movies
#'
#' \code{trakt.movies.popular} returns a list of the most popular movies on trakt.tv.
#' According to the API docs, opularity is calculated based both ratings and number of ratings.
#' @param limit Number of movies to return. Is coerced to \code{integer} and must be greater than 0.
#' @param page Page to return (default is \code{1})
#' for \href{http://docs.trakt.apiary.io/#introduction/pagination}{pagination}.
#' @param extended Whether extended info should be provided.
#' Defaults to \code{"min"}, can either be \code{"min"} or \code{"full"}
#' @return A \code{data.frame} containing popular movies with their name and ids
#' @export
#' @note See \href{http://docs.trakt.apiary.io/reference/movies/popular/get-popular-movies}{the trakt API docs for further info}
#' @family movie data
#' @family aggregated data
#' @examples
#' \dontrun{
#' get_trakt_credentials() # Set required API data/headers
#' trakt.movies.popular(5)
#' }
trakt.movies.popular <- function(limit = 10, page = 1, extended = "min"){

  response <- trakt.popular(type = "movies", limit = limit, page = page, extended = extended)

  return(response)
}

#' Get popular shows
#'
#' \code{trakt.shows.popular} returns a list of the most popular shows on trakt.tv.
#' According to the API docs, opularity is calculated based both ratings and number of ratings.
#' @param limit Number of shows to return. Is coerced to \code{integer} and must be greater than 0.
#' @param page Page to return (default is \code{1})
#' for \href{http://docs.trakt.apiary.io/#introduction/pagination}{pagination}.
#' @param extended Whether extended info should be provided.
#' Defaults to \code{"min"}, can either be \code{"min"} or \code{"full"}.
#' @return A \code{data.frame} containing popular shows with their name and ids
#' @export
#' @note See \href{http://docs.trakt.apiary.io/#reference/shows/get-popular-shows}{the trakt API docs for further info}
#' @family show data
#' @family aggregated data
#' @examples
#' \dontrun{
#' get_trakt_credentials() # Set required API data/headers
#' trakt.shows.popular(5)
#' }
trakt.shows.popular <- function(limit = 10, page = 1, extended = "min"){

  response <- trakt.popular(type = "shows", limit = limit, page = page, extended = extended)

  return(response)
}

#' @keywords internal
trakt.popular <- function(type, limit = 10, page = 1, extended = "min"){
  limit <- as.integer(limit)
  page  <- as.integer(page)
  if (limit < 1 | page < 1){
    stop("Limit and page must be greater than zero")
  }

  # Construct URL, make API call
  url      <- build_trakt_url(type, "popular", page = page, limit = limit, extended = extended)
  response <- trakt.api.call(url)

  # Spreading out ids to get a flat data.frame
  response <- cbind(response[names(response) != "ids"], response$ids)

  return(response)
}
