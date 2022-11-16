## Eduard Martínez
## update: 16-11-2022

## llamar la librería pacman: contiene la función p_load()
rm(list=ls())
require(pacman)
p_load(tidyverse, # contiene las librerías ggplot, dplyr...
       rvest) # web-scraping

## Acceder al robots.txt de wikipedia
browseURL("https://en.wikipedia.org/robots.txt")
browseURL("https://github.com/eduard-martinez/robots.txt")
## Mi primer HTML
## párrafo de html <p>. para cerralo uno le poner un slash antes el nombre del elemento
my_html <- 
'<!DOCTYPE html> 
<html>
<meta charset="utf-8">
<head>
<title> Título de la página: ejemplo de clase </title>
</head>
<body>
<h1> Title 1.</h1>
<h2> Subtitle <u>subrayado-1</u>. </h2>
<p> Este es un párrafo muy pequeño que se encuentra dentro de la etiqueta <b>p</b> de <i>html</i> </p>
<a href="https://es.wikipedia.org/wiki/Copa_Mundial_de_F%C3%BAtbol"> link a wikipedia </a>
</body>
</html>'

## export and read html
write.table(x=my_html , file='my_page.html' , quote=F , col.names=F , row.names=F)
browseURL("my_page.html") ## leer con el navegador de su equipo

## view rvest
vignette("rvest")

## 2.1 Aplicación en R:
my_url = "https://es.wikipedia.org/wiki/Copa_Mundial_de_F%C3%BAtbol"
browseURL(my_url) ## Ir a la página

## leer el html de la página
my_html <- read_html(my_url)

## ver la clase del objeto

class(my_html)
## ver el objeto


## 2.2 Extraer elementos de un HTML
##copiammos el xpath mediante inspeccionar

## Obtener los elementos h2 de la página
##html_
h2_fifa <-  my_html %>% html_nodes("h2")


## Ver los textos
h2_fifa %>% html_text()
my_html %>% html_elements("h2") %>% html_text()

## 2.3 Xpath

html_p <- my_html %>% html_nodes(xpath= '//*[@id="mw-content-text"]/div[1]/p[5]')##debe ser con una sola comilla porque dentro del texto hay comillas. Es necesario aclarar que es un xpath
my_html %>% html_nodes(xpath= '//*[@id="mw-content-text"]/div[1]/p[5]') %>% html_text() ##ponerlo en texto


## extraer los links dentro del párrafo
html_a <- html_p %>% html_elements("a")
html_a
html_a %>% html_attr("href") ##el atributo href es el que contiene el link. eso se puede vwer en el html
urls_p <- paste0("https://es.wikipedia.org/", html_a %>% html_attr("href"))

urls_p

## extraer todas las tablas del html 
my_table = my_html %>% html_table()

## numero de tablas extraidas
length(my_table)

tabla_jug <- my_table[[11]]

## tabla 10


sub_html = my_html %>% html_nodes(xpath='//*[@id="mw-content-text"]/div[1]/table[10]/tbody')
class(sub_html)

elements = sub_html %>% html_nodes("a")
elements[1:5]

titles = elements %>% html_attr("title")
titles[1:5]

refs = elements %>% html_attr("href")
refs[1:5]

db = tibble(titles,url=paste0("https://es.wikipedia.org",refs))
db %>% head()

browseURL(db$url[10])
lu


