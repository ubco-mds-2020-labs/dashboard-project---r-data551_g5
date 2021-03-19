# Reflection

## Implementation and New Features

The dashboard is currently under active development; the current release focuses on developing an interactive dashboard to provide insights into the number and trends of suicides in 101 countries by factors such as age, generation, GDP per capita. Suicide is a complex issue and is not limited to economic issues; we need to consider several other indices such as human development (HDI). HDI is a composite index measuring average achievement in critical dimensions of human development: standard of living, long and healthy life, and knowledge. It must be noted that HDI captures only a part of human development and often fails to reflect on inequalities that might be prevalent in society. This suggests that HDI alone might not be a good measure to understand the dynamics of suicide and thus will be used in conjunction with GDP per capita to paint a better picture. For this release, two tabs were added to the dashboard, which split the plots based on economic, socio-economic, age, generation, and gender-based factors. 

##  Team Dynamics
The team did a good job of distributing the workload; however, we faced difficulties transitioning from Python to R. As dash is relatively new (in R), the documentation and external resources were limited. Moreover, deployment on Heroku is not optimised for R, and it took a long time to decipher and debug the errors. 

## Current Limitations

At the moment, some plots have limited interactivity. For instance, users can only interact through dropdown menus in the next release; however, a slider will be implemented to select continuous variables such as suicides per 100k in-between years, HDI and GDP per capita. Users will also have the opportunity to sort box plots in ascending or descending order based on the number of suicides per 100k. 

## Future Releases
- Allowing the user to plot trendlines and preform simple regression
- Implementing an API instead of a static dataset to get insights on the impact of the pandemic on mental health
- Pointing users to additional resources such as research papers, news articles and journals.
- In-app navigation to help users understand how to use our dashboard. 