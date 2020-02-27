habr_hub_top_authors <-
function(hub) {
  
  hub_top   <- read_html( str_interp("https://habr.com/ru/hub/${hub}/authors/") )
  user_ids  <- html_nodes(hub_top, "#peoples li") %>% html_attr("id")
  
  result    <- map_df( user_ids, ~ tibble( name         = html_nodes(hub_top, str_interp("#${.x} .list-snippet__fullname")) %>% html_text,
                                           username     = html_nodes(hub_top, str_interp("#${.x} .list-snippet__nickname")) %>% html_text,
                                           life_time    = html_nodes(hub_top, str_interp("#${.x} .list-snippet__lifetime")) %>% html_text,
                                           invest       = html_nodes(hub_top, str_interp("#${.x} [class='stats__counter stats__counter_table-grid stats__counter_invest']")) %>% html_text %>% str_replace(",", ".") %>% as.numeric )
  )
  
  return(result)
  
}
