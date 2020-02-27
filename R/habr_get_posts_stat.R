habr_get_posts_stat <-
function(user) {
  
  
  posts_stats <-
    map_df(user, ~
            map_df(habr_user_post_id(.x), 
                   habr_get_post_stat, 
                   user = .x)
           )
    
  return(posts_stats)
  
}
