library(dash)
library(dashHtmlComponents)
library(dashCoreComponents)
library(dashBootstrapComponents)
library(ggplot2)
library(plotly)
library(dplyr)

####

source("PLOTS.R")

app <- Dash$new(external_stylesheets = dbcThemes$SANDSTONE)

app$layout(
  dccTabs(
    list(
      dccTab( label = "General Overview",
        dbcContainer(
          list(
            htmlBr(),
            htmlH2("SUICIDES: A GLOBAL IMPERATIVE"),
            htmlBr(),
            htmlDiv(list(
              dbcRow(list(
                
                dbcCol(list(dbcCard(dbcCardBody(list(htmlP(list(
                  'COUNTRY',
                  dccDropdown(
                    id= 'country-dropdown',
                    value = 'Canada',
                    options = country_data$region %>%
                      purrr::map(function(col) list(label = col, value= col))
                  ),
                  htmlBr(),
                  'AGE',
                  dccDropdown(
                    id= 'age-dropdown',
                    value = '15-24 years',
                    options = unique(data$age) %>%
                      purrr::map(function(col) list(label = col, value= col))
                  ),
                  htmlBr(),
                  'SEX',
                  dccDropdown(
                    id='sex-dropdown',
                    value = 'male',
                    options = unique(data$sex) %>%
                      purrr::map(function(col) list(label = col, value= col))
                  )
                )))))), style = list(width = 30)),
                dbcCol(list(dbcCard(dbcCardBody(list(htmlP(list(dccGraph(figure = plot1())))))))))),
              htmlBr(),
              dbcRow(list(
                dbcCol(list(dbcCard(dbcCardBody(list(htmlP(list(dccGraph(id= "plot2",
                                                                         figure = plot2(age='15-24 years', country= 'Canada',sex = 'male')
                                                                         )))))))),
                dbcCol(list(dbcCard(dbcCardBody(list(htmlP(list(dccGraph(id = 'plot5', figure = plot5(country = 'Canada'))))))))))),
              htmlBr()))))),
      dccTab(label = "Factors",
        dbcContainer(
        list(
          htmlBr(),
          dbcRow(list(
            dbcCol(list(dbcCard(dbcCardBody(list(htmlP(list(
              'COUNTRY',
              dccDropdown(
              id = 'country-dropdown-2',
              value = 'Canada',
              options = country_data$region %>%
                purrr::map(function(col) list(label = col, value= col)),
            )))))))),
            dbcCol(list(dbcCard(dbcCardBody(list(htmlP(list(
              'AGE',
              dccDropdown(
              id = 'age-dropdown-2',
              value = '15-24 years',
              options = unique(data$age) %>%
                purrr::map(function(col) list(label = col, value= col)),
            )))))))),
            dbcCol(list(dbcCard(dbcCardBody(list(htmlP(list(
              'SEX',
              dccDropdown(
              id = 'sex-dropdown-2',
              value = 'male',
              options = unique(data$sex) %>%
                purrr::map(function(col) list(label = col, value= col)),
            ))))))))
          ), style = list(display = 'flex')),
          htmlBr(),
          dbcRow(list(
            dbcCol(list(dbcCard(dbcCardBody(list(htmlP(list(
            dccGraph(id = 'plot6', figure = plot6(country_='Canada', sex_='male',age_='15-24 years'))))))))),
            dbcCol(list(dbcCard(dbcCardBody(list(htmlP(list(
            dccGraph(id = "plot4",figure = plot4(countries = 'Canada', gender= 'male')))))))))
          )
          ),
          htmlBr(),
          dbcRow(list(
            dbcCol(list(dbcCard(dbcCardBody(list(htmlP(list(
            dccGraph(figure = plot3()))))))))
          )),
          htmlBr()
        )
      ))
    )
  )
  
)

# Specify the required call backs:

# call back for plot1
app$callback(
  output('plot2','figure'),
  list(input('age-dropdown','value'),
       input('country-dropdown','value'),
       input('sex-dropdown', 'value')),
  function(age_select, country_select, sex_select){
    plot2(age = age_select, country= country_select, sex=sex_select)
  }
)



# call back for plot2
app$callback(
  output('plot4', 'figure'),
  list(input('country-dropdown-2','value'),
       input('sex-dropdown-2','value')),
  function(country_select, sex_select, age_select){
    plot4(countries = country_select, gender= sex_select)
  }
)


#Call back for plot6
app$callback(
  output('plot6', 'figure'),
  list(input('country-dropdown-2','value'),
       input('sex-dropdown-2','value'),
       input('age-dropdown-2','value')),
  function(country_select, sex_select,age_select){
    plot6(country_ = country_select, sex_= sex_select, age_ = age_select)
  }
)

#call back for plot5
app$callback(
  output('plot5','figure'),
  list(input('country-dropdown','value')),
  function(country_select){
    plot5(country= country_select)
  }
)

app$run_server(host = '0.0.0.0')


