library(dash)
library(dashHtmlComponents)
library(dashCoreComponents)
library(dashBootstrapComponents)
library(ggplot2)
library(plotly)
library(dplyr)
library(ggiraph)
####

source("C:/Users/mural/MDS/BLOCK5/DATA551_R/PLOTS_DATA/PLOTS.R")

app <- Dash$new(external_stylesheets = dbcThemes$LUX)

app$layout(
  dccTabs(
    list(
      dccTab(
        dbcContainer(
          list(
            htmlBr(),
            htmlH1("SUICIDE DASHBOARD"),
            htmlBr(),
            htmlDiv(list(
              dbcRow(list(
                dbcCol(list(
                  dccDropdown(
                    id= 'country-dropdown',
                    value = 'Canada',
                    options = country_data$region %>%
                      purrr::map(function(col) list(label = col, value= col)),
                    style = list(width =300)
                  ),
                  htmlBr(),
                  dccDropdown(
                    id= 'age-dropdown',
                    value = '15-24 years',
                    options = unique(data$age) %>%
                      purrr::map(function(col) list(label = col, value= col)),
                    style = list(width=300)
                  ),
                  htmlBr(),
                  dccDropdown(
                    id='sex-dropdown',
                    value = 'male',
                    options = unique(data$sex) %>%
                      purrr::map(function(col) list(label = col, value= col)),
                    style = list(width=300)
                  )
                ), style = list(width = 50)),
                dbcCol(dccGraph(figure = plot1()),style = list(width=2000, justify='right'))
              )
              ),
              htmlBr(),
              htmlLabel("Second Half of the graph"),
              dbcRow(list(
                dbcCol(
                  dccGraph(id= "plot2",figure = plot2(age='15-24 years'))
                ),
                dbcCol(dccGraph(figure = plot3()))))
            ))
          )
        )
      ),
      dccTab(dbcContainer(
        list(
          htmlBr(),
          htmlH2("This is the content for the second tab"),
          dbcRow(list(
            dbcCol(dccGraph(figure = plot3()))
          )),
          dbcRow(list(
            dbcCol(dccGraph(figure = plot3())),
            dbcCol(dccGraph(figure = plot3()))
          )
          )
        )
      ))
    )
  )
  
)

# Specify the required call backs:

# Testing on Yatin's plot:
app$callback(
  output('plot2','figure'),
  list(input('age-dropdown','value')),
  function(selected_data){
    plot2(age = selected_data)
  }
)



app$run_server(debug = T)
