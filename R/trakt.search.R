#' Search for a show via text query
#'
#' \code{trakt.search} returns search result info.
#'
#' Search for a show or movie with a keyword (e.g. \code{"Breaking Bad"}) and receive basic info of the first
#' search result. It's main use is to retrieve the ids or proper show/movie title for further use, as well
#' as receiving a quick overview of a show/movie.
#' @param query The keyword used for the search. If the query ends with a 4 digit numbers,
#' this will be used as \code{year} parameter.
#' @param type The type of data you're looking for. Defaults to \code{show}, can also be
#'   \code{movie}, \code{episode}, \code{person} or \code{list}.
#' @param year Optionally filter by year.
#' @return A \code{data.frame} containing a single search result. Hopefully the one you wanted. If
#'   no result is found, the return value is \code{list(error = "Nothing found")} and a
#'   \code{warning}
#' @export
#' @importFrom stringr str_match
#' @importFrom stringr str_replace
#' @importFrom stringr str_trim
#' @note See \href{http://docs.trakt.apiary.io/reference/search/text-query}{the trakt API docs for
#'   further info}
#' @family API-basics
#' @family search functions
#' @examples
#' \dontrun{
#' get_trakt_credentials() # Set required API data/headers
#' breakingbad <- trakt.search("Breaking Bad")
#' }
trakt.search <- function(query, type = "show", year = NULL){

  # Parse query for possible year
  if (is.null(year) & !(is.na(stringr::str_match(query, "(\\d{4})$")[1]))){
    year  <- stringr::str_match(query, "(\\d{4})$")[1]
    query <- stringr::str_replace(query, "(\\d{4})$", "")
    query <- stringr::str_trim(query)
  }

  # Construct URL, make API call
  url      <- build_trakt_url("search", query = query, type = type, year = year)
  response <- trakt.api.call(url = url, convert.datetime = F)

  # Check if response is empty (nothing found)
  if (identical(response, list())){
    warning("No result, sorry.")
    return(list(error = "Nothing found"))
  }

  # Try to find the closest match via basic string comparison (Could use improvement)
  stringmatch <- match(tolower(URLdecode(query)), tolower(response[[type]]$title))

  # Cleanup received data, using only matched line
  if (is.na(stringmatch)){
    warning("No exact match found, using trakt.tv's best guess")
    result <- response[1, ][[type]]
  } else {
    result <- response[stringmatch, ][[type]]
  }

  return(result)
}

#' Lookup a show via id
#'
#' \code{trakt.search.byid} pulls show stats and returns it compactly.
#'
#' @param id The id used for the search. Will be \code{URLencode}'d.
#' @param id_type The type of \code{id}. Defaults to \code{trakt-show}, can be
#' \code{trakt-movie}, \code{trakt-show}, \code{trakt-episode}, \code{imdb},
#' \code{tmdb}, \code{tvdb}, \code{tvrage}
#' @return A \code{data.frame} containing a single search result. Hopefully the one you wanted.
#' If no result is found, the return value is \code{list(error = "Nothing found")} and a \code{warning}
#' @export
#' @importFrom jsonlite fromJSON
#' @import httr
#' @note See \href{http://docs.trakt.apiary.io/reference/search/id-lookup/get-id-lookup-results}{the trakt API docs for further info}
#' @family API-basics
#' @family search functions
#' @examples
#' \dontrun{
#' get_trakt_credentials() # Set required API data/headers
#' breakingbad <- trakt.search.byid(1388, "trakt-show")
#' }
trakt.search.byid <- function(id, id_type = "trakt-show"){

  # Construct URL, make API call
  url      <- build_trakt_url("search", id_type = id_type, id = id)
  response <- trakt.api.call(url = url)

  # Check if response is empty (nothing found)
  if (identical(response, list())){
    warning("No result, sorry.")
    return(list(error = "Nothing found"))
  }
  response <- response[[ncol(response)]]
  return(response)
}
