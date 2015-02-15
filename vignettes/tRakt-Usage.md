---
title: "Using tRakt"
author: "Jemus42"
date: "2015-02-16"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteIndexEntry{Using tRakt}
  %\VignetteEngine{knitr::knitr}
  \usepackage[utf8]{inputenc}
---
## First step: Loading packages and trakt.tv credentials


```r
suppressPackageStartupMessages(library(tRakt)) 
suppressPackageStartupMessages(library(dplyr)) # For convenience
library(ggplot2) # For plotting (duh)
library(knitr)   # for knitr::kable, used to render simple tables

# If you don't have a client.id defined in a key.json, use mine
if (is.null(getOption("trakt.client.id"))){
  get_trakt_credentials(client.id = "12fc1de7671c7f2fb4a8ac08ba7c9f45b447f4d5bad5e11e3490823d629afdf2")
}
```

## Let's pull some data

### Search

There are two ways to search on trakt.tv. The first is via text query (i.e. `Game of Thrones`),
the second is via ID (various types supported).  

At the time of this writing (2015-02-16), the trakt.tv search is a little derpy, so search by ID is recommended.


```r
# Search via text query
show1  <- trakt.search("Game of Thrones")

# Search via ID (trakt id is used by default)
show2 <- trakt.search.byid(1390) # trakt id of Game of Thrones

# The returned data is identical
identical(show1, show2)
```

```
## [1] TRUE
```

### Getting more data


```r
# Search a show and receive basic info
show          <- trakt.search("Breaking Bad")
# Save the slug of the show, that's needed for other functions as an ID
slug          <- show$ids$slug
slug
```

```
## [1] "breaking-bad"
```

```r
# Get the season & episode data
show.seasons  <- trakt.getSeasons(slug) # How many seasons are there?
show.episodes <- trakt.getEpisodeData(slug, show.seasons$season, extended = "full")

# Glimpse at data (only some columns each)
rownames(show.seasons) <- NULL # This shouldn't be necessary
show.seasons[c(1, 3, 4)] %>% kable
```



| season|  rating| votes|
|------:|-------:|-----:|
|      1| 8.44355|   124|
|      2| 9.01961|   102|
|      3| 8.93000|   100|
|      4| 9.21739|    92|
|      5| 9.23913|    92|

```r
show.episodes[c(1:3, 6, 7, 17)] %>% head(10) %>% kable
```



|season | episode|title                         |  rating| votes|firstaired.string |
|:------|-------:|:-----------------------------|-------:|-----:|:-----------------|
|1      |       1|Pilot                         | 8.67205|  2540|2008-01-21        |
|1      |       2|Cat's in the Bag...           | 8.47242|  1922|2008-01-28        |
|1      |       3|...And the Bag's in the River | 8.36136|  1760|2008-02-11        |
|1      |       4|Cancer Man                    | 8.33920|  1704|2008-02-18        |
|1      |       5|Gray Matter                   | 8.29345|  1663|2008-02-25        |
|1      |       6|Crazy Handful of Nothin'      | 8.90687|  1761|2008-03-03        |
|1      |       7|A No-Rough-Stuff-Type Deal    | 8.69036|  1702|2008-03-10        |
|2      |       1|Seven Thirty-Seven            | 8.48705|  1622|2009-03-09        |
|2      |       2|Grilled                       | 8.71402|  1612|2009-03-16        |
|2      |       3|Bit by a Dead Bee             | 8.27689|  1506|2009-03-23        |

## Some example graphs

Plotting the data is pretty straight forward since I try to return regular `data.frames` without 
unnecessary ambiguitiy.


```r
show.episodes$episode_abs <- 1:nrow(show.episodes) # I should probably do that for you.
show.episodes %>%
  ggplot(aes(x = episode_abs, y = rating, colour = season)) +
    geom_point(size = 3.5, colour = "black") +
    geom_point(size = 3) + 
    geom_smooth(method = lm, se = F) +
    labs(title = "Trakt.tv Ratings of Breaking Bad", 
         y = "Rating", x = "Episode (absolute)", colour = "Season")
```

<img src="figure/Graphing_1-1.png" title="plot of chunk Graphing_1" alt="plot of chunk Graphing_1" style="display: block; margin: auto;" />

```r
show.episodes %>%
  ggplot(aes(x = episode_abs, y = votes, colour = season)) +
    geom_point(size = 3.5, colour = "black") +
    geom_point(size = 3) + 
    labs(title = "Trakt.tv User Votes of Breaking Bad Episodes", 
         y = "Votes", x = "Episode (absolute)", colour = "Season")
```

<img src="figure/Graphing_1-2.png" title="plot of chunk Graphing_1" alt="plot of chunk Graphing_1" style="display: block; margin: auto;" />

```r
show.episodes %>%
  ggplot(aes(x = episode_abs, y = scale(rating), fill = season)) +
    geom_bar(stat = "identity", colour = "black", position = "dodge") +
    labs(title = "Trakt.tv User Ratings of Breaking Bad Episodes\n(Scaled using mean and standard deviation)", 
         y = "z-Rating", x = "Episode (absolute)", fill = "Season")
```

<img src="figure/Graphing_1-3.png" title="plot of chunk Graphing_1" alt="plot of chunk Graphing_1" style="display: block; margin: auto;" />

## Now some user-specific data

User-specific functions (`trakt.user.*`) default to `user = getOption("trakt.username")`, which
should have been set by `get_trakt_credentials()`, so you get your own data per default.  
However, you can specifiy any publicly available user. Note that OAuth2 is not supported, so 
by "publicly available user", I really mean only non-private users.





