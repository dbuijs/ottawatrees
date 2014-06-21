
library(shiny)
library(leaflet)

# Choices for drop-downs
#vars <- c(
#  "Is SuperZIP?" = "superzip",
#  "Centile score" = "centile",
#  "College education" = "college",
#  "Median income" = "income",
#  "Population" = "adultpop"
#)


shinyUI(navbarPage("Ottawa Trees", id="nav",
                   
                   tabPanel("Interactive map",
                            div(class="outer",
                                
                                tags$head(
                                  # Include our custom CSS
                                  includeCSS("styles.css")
                                  #, includeScript("gomap.js")
                                ),
                                
                                leafletMap("map", width="100%", height="100%", 
                                             initialTileLayer = "//{s}.tile.stamen.com/toner/{z}/{x}/{y}.png",
                                             initialTileLayerAttribution = HTML('Map tiles by <a href="http://stamen.com">Stamen Design</a>, <a href="http://creativecommons.org/licenses/by/3.0">CC BY 3.0</a> &mdash; Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>'),
                                             options=list(
                                               center = c(45.3640, -75.7511),
                                               zoom = 12,
                                               maxBounds = list(list(45.1840,-76.1140), list(45.5444,-75.3896)) 
                                             )
                                  ),
                                  
                                           
                               
                                
                               # absolutePanel(id = "controls", class = "modal", fixed = TRUE, draggable = TRUE,
                              #                top = 60, left = "auto", right = 20, bottom = "auto",
                              #                width = 330, height = "auto",
                              #                
                              #                h2("ZIP explorer"),
                              #                
                              #                selectInput("color", "Color", vars),
                              #                selectInput("size", "Size", vars, selected = "adultpop"),
                              #                conditionalPanel("input.color == 'superzip' || input.size == 'superzip'",
                              #                                 # Only prompt for threshold when coloring or sizing by superzip
                              #                                 numericInput("threshold", "SuperZIP threshold (top n percentile)", 5)
                              #                ),
                              #                
                              #                plotOutput("histCentile", height = 200),
                              #                plotOutput("scatterCollegeIncome", height = 250)
                              #  ),
                              #  
                                tags$div(id="cite",
                                         'Data obtained from ', tags$em('http:data.ottawa.ca')
                                )
                            )
                   )
                   
# ,                  tabPanel("Data explorer",
#                            fluidRow(
#                              column(3,
#                                     selectInput("states", "States", c("All states"="", structure(state.abb, names=state.name), "Washington, DC"="DC"), multiple=TRUE)
#                              ),
#                              column(3,
#                                     conditionalPanel("input.states",
#                                                      selectInput("cities", "Cities", c("All cities"=""), multiple=TRUE)
#                                     )
#                              ),
#                              column(3,
#                                     conditionalPanel("input.states",
#                                                      selectInput("zipcodes", "Zipcodes", c("All zipcodes"=""), multiple=TRUE)
#                                     )
#                              )
#                            ),
#                            fluidRow(
#                              column(1,
#                                     numericInput("minScore", "Min score", min=0, max=100, value=0)
#                              ),
#                              column(1,
#                                     numericInput("maxScore", "Max score", min=0, max=100, value=100)
#                              )
#                            ),
#                            hr(),
#                            dataTableOutput("ziptable")
#                   ),
#                   
#                   conditionalPanel("false", icon("crosshair"))
))