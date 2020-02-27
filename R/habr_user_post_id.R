habr_user_post_id <-
function(user) {

  if ( class(user) == "list" ) {
  
        post_ids <- map(user, ~
                        html_nodes(.x, "[class='content-list__item content-list__item_post shortcuts_item']") %>% html_attr("id")) %>%
                    unlist
  
  } else {
    
         post_ids <- html_nodes(user, "[class='content-list__item content-list__item_post shortcuts_item']") %>% html_attr("id")
    
  }
  
  return(post_ids)
  
}
