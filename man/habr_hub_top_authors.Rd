\name{habr_hub_top_authors}
\alias{habr_hub_top_authors}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Get top HUB authors
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
habr_hub_top_authors(hub)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{hub}{
%%     ~~Describe \code{hub} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (hub) 
{
    hub_top <- read_html(str_interp("https://habr.com/ru/hub/${hub}/authors/"))
    user_ids <- html_nodes(hub_top, "#peoples li") \%>\% html_attr("id")
    result <- map_df(user_ids, ~tibble(name = html_nodes(hub_top, 
        str_interp("#${.x} .list-snippet__fullname")) \%>\% html_text, 
        username = html_nodes(hub_top, str_interp("#${.x} .list-snippet__nickname")) \%>\% 
            html_text, life_time = html_nodes(hub_top, str_interp("#${.x} .list-snippet__lifetime")) \%>\% 
            html_text, invest = html_nodes(hub_top, str_interp("#${.x} [class='stats__counter stats__counter_table-grid stats__counter_invest']")) \%>\% 
            html_text \%>\% str_replace(",", ".") \%>\% as.numeric))
    return(result)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
