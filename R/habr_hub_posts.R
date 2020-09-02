# hab top authors
habr_hub_posts <- function(hub, page_number = 0) {
  
  if ( str_detect(string = hub, pattern = "^http") ) {
    
    hub <- str_replace("https://habr.com/ru/hub/r/", 
                       pattern = ".*(hub)/(.*)/(.*)", 
                       replacement = "\\2")
    
  }
  
  link      <- str_interp("https://habr.com/ru/hub/${hub}/") 
  res       <- list()
  to_next   <- TRUE
  page_num  <- 1
  
  while ( to_next ) {
    
    hub_top   <- read_html( link )
    post_ids  <- html_nodes(hub_top, ".posts_list [class='content-list__item content-list__item_post shortcuts_item']") %>% html_attr("id") %>% .[ !is.na(.) ]
    
    
    result_temp  <- map_df( post_ids, ~ tibble( title        = html_nodes(hub_top, str_interp("#${.x} .post__title_link")) %>% html_text,
                                                link         = html_nodes(hub_top, str_interp("#${.x} .post__title_link")) %>% html_attr('href'),
                                                author       = html_nodes(hub_top, str_interp("#${.x} [class='user-info__nickname user-info__nickname_small']")) %>% html_text,
                                                date         = html_nodes(hub_top, str_interp("#${.x} [class='post__time']")) %>% html_text,
                                                hubs         = html_nodes(hub_top, str_interp("#${.x} [class='post__hubs inline-list']")) %>% html_text %>% str_remove_all("\n        |\n    ") %>% str_trim,
                                                rating       = html_nodes(hub_top, str_interp("#${.x} [class='post-stats__result-counter voting-wjt__counter_positive ']")) %>% html_text %>% as.numeric,
                                                bookmarks    = html_nodes(hub_top, str_interp("#${.x} [class='bookmark__counter js-favs_count']")) %>% html_text %>% as.numeric, 
                                                views        = html_nodes(hub_top, str_interp("#${.x} [class='post-stats__views-count']"))  %>% html_text %>% str_replace(",", ".") %>% str_replace("k|K", "e3") %>% as.numeric)
                         
    )
    
    
    res <- append(res, list(result_temp))
    
    next_page <- html_nodes(hub_top, "[class='arrows-pagination__item-link arrows-pagination__item-link_next']") %>% html_attr("href")
    
    
    if ( length(next_page) > 0 & ( page_number == 0 | page_num < page_number)  ) {
      
      link <- str_c("https://habr.com/", next_page, collapse = "")
      Sys.sleep(1)
    } else {
      
      to_next <- FALSE
      
    }
    
    page_num <- page_num + 1
    
  }
  
  result <- bind_rows(res)
  return(result)
  
}