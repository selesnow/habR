habr_user <-
function(username) {
  
  user_list <- list()
  link      <- str_interp("https://habr.com/ru/users/${username}/posts/")
  to_next <- TRUE
  
  while ( to_next ) {
    
    user <- read_html(link)
    
    user_list <- append(user_list, list(user))
    
    next_page <- html_nodes(user, "[class='arrows-pagination__item-link arrows-pagination__item-link_next']") %>% html_attr("href")
    
    if ( length(next_page) > 0  ) {
      
      link <- str_c("https://habr.com/", next_page, collapse = "")
      Sys.sleep(1)
    } else {
      
      to_next <- FALSE
      
    }
    
  }

  
  
  return(user_list)
  
}
