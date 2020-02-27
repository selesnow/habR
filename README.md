# hubR
R Пакет для анализа хабов и авторов сайта habr.com

# пример использования
```r
library(habR)
library(purrr)
library(forcats)
library(dplyr)
library(ggplot2)

# ##########################
# Сбор и анализ
# собираем лучших авторов хаба
top_authors <- habr_hub_top_authors("r")

# собираем статистику по статьям 15 лучших авторов хаба
rhub_top <- map_df( head(top_authors$username, 15), ~ habr_user(.x) %>%  habr_get_posts_stat )

# к-во статей
rhub_top %>% 
  group_by(author) %>% 
  count() %>% 
  ggplot(aes(x = fct_reorder(author, n, .desc = TRUE) , y = n)) + 
  geom_col(aes(fill = n)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  labs(x = "Автор", y = "Количество публикаций") +
  ggtitle("Количество статей лучших авторов Хаба Язык R")
  ```
