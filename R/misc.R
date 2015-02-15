#' Easy episode id padding
#' 
#' Simple function to ease the creation of \code{sXXeYY} episode ids.
#' @param s Input season number, coerced to \code{character}.
#' @param e Input episode number, coerced to \code{character}.
#' @param width The length of the padding. Defaults to 2.
#' @return A \code{character} in standard \code{sXXeYY} format
#' @export
#' @note I like my sXXeYY format, okay?
#' @examples
#' pad(2, 4) # Returns "s02e04"
pad <- function(s = "0", e = "0", width = 2){
  s <- as.character(s)
  e <- as.character(e)
  season <- sapply(s, function(x){
              if (nchar(x, "width") < width){
                missing <- width - nchar(x, "width")
                x.pad   <- paste0(rep("0", missing), x)
                return(x.pad)
              } else {
                return(x)
              }
            })
  episode <- sapply(e, function(x){
                if (nchar(x, "width") < width){
                  missing <- width - nchar(x, "width")
                  x.pad   <- paste0(rep("0", missing), x)
                  return(x.pad)
                } else {
                  return(x)
                }
              })
  epstring <- paste0("s", season, "e", episode)
  return(epstring)
}

#' Get info from a show URL
#'
#' \code{getNameFromURL} extracts some info from a show URL
#' @param url Input URL. must be a \code{character}, but not a valid URL.
#' @param epid Whether the episode ID (\code{sXXeYY} format) should be extracted. 
#' Defaults to \code{FALSE}.
#' @param getslug Whether the \code{slug} should be extracted. Defaults to \code{FALSE}.
#' @return A \code{list} containing at least the show name.
#' @export
#' @importFrom stringr str_split
#' @note This is pointless.
#' @examples
#' \dontrun{
#' getNameFromURL("http://trakt.tv/show/fargo/season/1/episode/2", T, T)
#' getNameFromURL("http://trakt.tv/show/breaking-bad", T, F)
#' }
getNameFromURL <- function(url, epid = FALSE, getslug = FALSE){
  showname <- stringr::str_split(url, "/")[[1]][5]
  ret <- list("show" = showname)
  if (epid){
    season   <- stringr::str_split(url, "/")[[1]][7]
    episode  <- stringr::str_split(url, "/")[[1]][9]
    if(is.na(season) | is.na(episode)){
      ret$epid <- NA
    } else{
      epid     <- pad(season, episode)
      ret$epid <- epid 
    }
  }
  if (getslug){
    slug <- stringr::str_split(url, "/", 5)
    ret$slug <- slug[[1]][5]
  }
  return(ret)
  # Most of this is pointless.
}