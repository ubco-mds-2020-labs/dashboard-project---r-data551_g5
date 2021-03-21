# For all the plots:

library(ggplot2)
library(plotly)
library(dplyr)
library(ggthemes)
library(dplyr)


# Read the required data set:
data <- read.csv("data/master.csv")
data <- data[complete.cases(data), ]

# Reaname the column as country:
names(data)[1] <- 'country'

# Aggregate the required dataset
country_data <- data %>%  
  group_by(data$country) %>%
  summarise(
    suicides_no = mean(suicides_no)
  )
country_data <- as.data.frame(country_data)
# Rename the columns so that they are helpful for merging:
names(country_data) <- c("region", "average_suicides")



# Read the required chloropeth dataset:
df <- read.csv('https://raw.githubusercontent.com/plotly/datasets/master/2014_world_gdp_with_codes.csv')
names(df)[1] <- "region"

# Read the required suicide dataset:
suicide_data <- read.csv("data/master_HDI.csv")

#setdiff(country_data$region, df$region)

# Rename the missing countries:
country_data$region[country_data$region == "Russian Federation"] <- "Russia"

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
    z = ~average_suicides, color= ~average_suicides,
    colors = 'plasma',
    text = ~region, locations = ~CODE, marker = list(line = l)
  )
  fig <- fig %>% layout(
    geo = g,
    width = 800,
    height = 400,
    paper_bgcolor = 'white'
  )
  return(fig)
}


# Yatin's Graph:
plot1_data<- read.csv("data/line_data.csv")
plot1_data$year <- as.Date(plot1_data$year,format="%Y")
plot1_data$age <- as.factor(plot1_data$age)

plot2 <- function(age, country){
  plot1_data <- plot1_data[plot1_data$age == age,]
  plot1_data <- plot1_data[plot1_data$country == country,]
  g <- ggplot(plot1_data, aes(x = year, y = Average_suicides_per_capita, colour = age))+geom_line() +
    labs(title="Average Suicides per Capita by year Colored by Age",
         x="year",
         y="Average_suicides_per_capita")
  g1 <- g+theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                panel.background = element_blank(), axis.line = element_line(colour = "black"))

  return(ggplotly(g1))
}


# Poojitha's Graph:
diverge_gender <- read.csv("data/diverge_data.csv")

x <- diverge_gender[order(diverge_gender$Average_suicides_per_capita, decreasing = TRUE),]
y <- x$country
top_n <- y[1:20]
diverge_gender_plot <- diverge_gender[diverge_gender$country %in% top_n,]

diverge_gender_plot <- diverge_gender_plot %>%
  mutate(Average_suicides_per_capita = ifelse(sex == "male",
                                              Average_suicides_per_capita,
                                              -1*Average_suicides_per_capita))

plot3 <- function(){
  p1 <- diverge_gender_plot %>%
    ggplot(aes(x = country, y = Average_suicides_per_capita, fill = sex))+
    geom_bar(stat = "identity")+
    coord_flip()+labs(title="Sex based factors") + ggtitle('Sex based factors(Top 20 Countries by Average_suicides_per_Capita)')
  p1 <- p1+theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                 panel.background = element_blank(), axis.line = element_line(colour = "black"))

  return(ggplotly(p1))
}


# Aditya plot:

plot4 <- function(countries, gender){
  data_subset <- subset(suicide_data, country==countries & sex==gender)
  p4 <- ggplot(data_subset, aes(x=year, y=suicides.100k.pop)) + 
    geom_point(aes(size = HDI, color = age)) +
    ggtitle('Suicides per capita by Year') +
    xlab('Year') + ylab('Suicides per 100k Population')
  g1 <- p4+theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                panel.background = element_blank(), axis.line = element_line(colour = "black"))
  
  return(ggplotly(g1))
}

# Sowmya's plot
plot5 <- function(country_data){
  
  p5 <- ggplot(data = data)+
    aes(x = data$generation,
        y = data$suicides.100k.pop,
        color = generation,
    )+
    geom_boxplot(text = paste('generation', data$generation))+
    facet_wrap(~data$sex)+
    #ggtitle("Suicides per 100k vs generation")+
    ylab("Suicides per 100k")+
    xlab("Generation")+theme_bw()+
    theme(axis.title.x=element_blank(),
          axis.text.x=element_blank(), 
          axis.ticks.x=element_blank(),
          legend.position = "bottom")

  
  return(ggplotly(p5) %>%
           layout(legend = list(orientation= "h", x= 0, y= 0)
           ))
}

# Aditya's plot:

plot6 <- function(country_, sex_, age_){
  data_subset <- subset(data, country== country_ & sex==sex_ & age==age_)
  g6 <- ggplot(data_subset, aes(x=year, y=suicides.100k.pop)) + 
    geom_point(aes(size = 'gdp_per_capita')) +
    ggtitle('GDP Trends by year') +
    xlab('Year') + ylab('Suicides per 100k Population')
 g6 <-  g6+theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
          panel.background = element_blank(), axis.line = element_line(colour = "black"))
  return(ggplotly(g6))
}


