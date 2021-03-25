plot1_data<- read.csv("data/line_data.csv")
head(plot1_data)
plot1_data$year <- as.Date(plot1_data$year,format="%Y")
plot1_data$age <- as.factor(plot1_data$age)

plot2 <- function(age, country, sex){
  plot1_data <- plot1_data[plot1_data$age == age,]
  plot1_data <- plot1_data[plot1_data$country == country,]
  plot1_data <- plot1_data[plot1_data$sex == sex,]
  head(plot1_data)
  g <- ggplot(plot1_data, aes(x = year, y = Average_suicides_per_capita, colour = age))+geom_line() +
    labs(title="Average Suicides per Capita by Year",
         x="Year",
         y="Average Suicides per Capita")
  g1 <- g+theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                panel.background = element_blank(), axis.line = element_line(colour = "black"))
  
  return(ggplotly(g1))
}

plot2(age = "15-24 years", country = "Canada", sex = "male")

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
    xlab('Average Suicides per Capita') + ylab('Country')+
    geom_bar(stat = "identity")+
    coord_flip()+labs(title="Sex based Factors") + ggtitle('Sex-based Factors (Top 20 countries by average suicides per capita)')
  p1 <- p1+theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                 panel.background = element_blank(), axis.line = element_line(colour = "black"))
  
  return(ggplotly(p1))
}
