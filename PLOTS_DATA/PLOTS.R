# For all the plots:

library(ggplot2)
library(plotly)
library(dplyr)
library(ggiraph)
library(ggthemes)
library(dplyr)
library(gghighlight)
#install.packages("gghighlight")

# Read the required data set:
data <- read.csv("master.csv")

# Reaname the column as country:
names(data)[1] <- 'country'

# Aggregate the required dataset
country_data <- data %>%  
  group_by(data$country) %>%
  summarise(
    suicides_no = mean(suicides_no)
  )

# Rename the columns so that they are helpful for merging:
names(country_data) <- c("region", "value")



# Read the required chloropeth dataset:
df <- read.csv('https://raw.githubusercontent.com/plotly/datasets/master/2014_world_gdp_with_codes.csv')
names(df)[1] <- "region"


#setdiff(country_data$region, df$region)

# Rename the missing countries:
country_data[country_data$region == "Russian Federation",]$region <- "Russia"

# Create a merged data set:
suicide_df <- left_join(df, country_data, by= "region")

# The code for the world map:

plot1 <- function(){
  # light grey boundaries
  l <- list(color = toRGB("grey"))
  # specify map projection/options
  g <- list(
    showframe = TRUE,
    showland = TRUE,
    showcoastlines = FALSE,
    showcountries = FALSE,
    countrycolor = toRGB("white"),
    projection = list(type = 'Mercator'),
    landcolor = toRGB("grey90")
  )
  fig <- plot_geo(suicide_df)
  fig <- fig %>% add_trace(
    z = ~value, color= ~value,
    colors = 'plasma',
    text = ~region, locations = ~CODE, marker = list(line = l)
  )
  fig <- fig %>% layout(
    geo = g,
    width = 800,
    height = 300,
    paper_bgcolor = '#F5F5DC'
  )
  return(fig)
}


# Yatin's Graph:
plot1_data<- read.csv("line_data.csv")
plot1_data$year <- as.Date(plot1_data$year,format="%Y")
plot1_data$age <- as.factor(plot1_data$age)
head(plot1_data)

plot2 <- function(age){
  plot1_data <- plot1_data[plot1_data$age == age,]
  g <- ggplot(plot1_data, aes(x = year, y = Average_suicides_per_capita, colour = age))+geom_line() +
    labs(title="Average Suicides per Capita by year Colored by Age",
         x="year",
         y="Average_suicides_per_capita")
  g1 <- g+theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                panel.background = element_blank(), axis.line = element_line(colour = "black"))
  
  
  g1 <- g1+theme(axis.text=element_text(size=5),
                 axis.title=element_text(size=5,face="bold"),
                 legend.title = element_text(color = "black", size = 5),
                 legend.text = element_text(color = 'black', size = 5))
  return(ggplotly(g1))
}


# Poojitha's Graph:
diverge_gender <- read.csv("diverge_data.csv")
head(diverge_gender)

diverge_gender_plot <- diverge_gender %>%
  mutate(Average_suicides_per_capita = ifelse(sex == "male",
                                              Average_suicides_per_capita,
                                              -1*Average_suicides_per_capita))

plot3 <- function(){
  options(repr.plot.width = 20, repr.plot.height = 50)
  p1 <- diverge_gender_plot %>%
    ggplot(aes(x = country, y = Average_suicides_per_capita, fill = sex))+
    geom_bar(stat = "identity")+
    coord_flip()+labs(title="Sex based factors")
  p1 <- p1+theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                 panel.background = element_blank(), axis.line = element_line(colour = "black"))
  p2 <- p1+theme(axis.text=element_text(size=5),
           axis.title=element_text(size=5,face="bold"),
           plot.title = element_text(size=5),
           legend.position = 'top',
           legend.title = element_blank(),
           legend.text = element_text(size = 5))
  return(ggplotly(p2))
}
