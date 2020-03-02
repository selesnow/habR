# hubR
R Пакет для анализа хабов и авторов сайта habr.com.

Позволяет получить следующую информацию:
* Собрать список лучших авторов любого Хаба
* Собрать полный список статей и их статистику по любому автору на Хабре
* Собрать полный список статей со статистикой и ссылками на них из любого Хаба

# установка
```r
devtools::install_github("selesnow/habR")
```

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

# к-во статей по авторам
rhub_top %>% 
  group_by(author) %>% 
  count() %>% 
  ggplot(aes(x = fct_reorder(author, n, .desc = TRUE) , y = n)) + 
  geom_col(aes(fill = n)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  labs(x = "Автор", y = "Количество публикаций") +
  ggtitle("Количество статей лучших авторов Хаба Язык R")
  
  
# забираем все посты с хаба R
hub_super_r <- habr_hub_posts("https://habr.com/ru/hub/r/")

# смотрим с какими хабами обычно постят статьи в хаб R
# смотрим смежные хабы
hub_r %>%
  mutate(hab_list = str_split(hubs, ",   ")) %>%
  unnest_longer(hab_list) %>%
  filter(hab_list != "R") %>%
  group_by(hab_list) %>%
  count(sort = T) %>%
  head(25) %>%
  ggplot(aes(x = fct_reorder(hab_list, n, .desc = TRUE) , y = n)) + 
  geom_col(aes(fill = n)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  labs(x = "Хаб", y = "Количество публикаций") +
  ggtitle("Наиболее популярные смежные хабы")
```
