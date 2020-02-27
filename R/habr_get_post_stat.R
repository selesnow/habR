habr_get_post_stat <-
function(x, user) {
  
  df <- data.frame(title     = html_nodes(user, str_interp("#${x} .post__title_link")) %>% html_text(),
                   link      = html_nodes(user, str_interp("#${x} .post__title_link")) %>% html_attr("href"),
                   datetime  = html_nodes(user, str_interp("#${x} .post__time")) %>% html_text(),
                   author    = html_nodes(user, str_interp("#${x} [class='user-info__nickname user-info__nickname_small']")) %>% html_text(),
                   habs      = html_nodes(user, str_interp("#${x} [class='inline-list__item inline-list__item_hub']")) %>% html_text %>% str_trim %>% str_c(collapse = " "),
                   views     = ifelse(is.null(html_nodes(user, str_interp("#${x} .post-stats__views-count")) %>% html_text), NA, html_nodes(user, str_interp("#${x} .post-stats__views-count")) %>% html_text %>% str_replace(",", ".") %>% str_replace("k|K", "e3") %>% as.numeric),
                   rating    = ifelse(is.null(html_nodes(user, str_interp("#${x} [class='post-stats__result-counter voting-wjt__counter_positive ']")) %>% html_text), NA, html_nodes(user, str_interp("#${x} [class='post-stats__result-counter voting-wjt__counter_positive ']")) %>% html_text %>% as.numeric),
                   bookmarks = ifelse(is.null(html_nodes(user, str_interp("#${x} [class='bookmark__counter js-favs_count']")) %>% html_text), NA, html_nodes(user, str_interp("#${x} [class='bookmark__counter js-favs_count']")) %>% html_text %>% as.numeric),
                   comments  = ifelse(is.null(html_nodes(user, str_interp("#${x} [class='post-stats__comments-count']")) %>% html_text), NA, html_nodes(user, str_interp("#${x} [class='post-stats__comments-count']")) %>% html_text %>% as.numeric)) 

  return(df)  
}
