# Reflection

## Implementation and New Features

The dashboard is production ready; the current release focuses on developing an interactive dashboard to provide insights into the number and trends of suicides in 101 countries by factors such as age, generation, GDP per capita. Suicide is a complex issue and is not limited to economic issues; we need to consider several other indices such as human development (HDI). HDI is a composite index measuring average achievement in critical dimensions of human development: standard of living, long and healthy life, and knowledge. It must be noted that HDI captures only a part of human development and often fails to reflect on inequalities that might be prevalent in society. This suggests that HDI alone might not be a good measure to understand the dynamics of suicide and thus will be used in conjunction with GDP per capita to paint a better picture. Based on beta-testing (peer-feedback from presentation 1), all plots were placed within a card body, a lighter theme was used and two tabs were added to the dashboard, which split the plots based on economic, socio-economic, age, generation, and gender-based factors to improve the flow/layout of the dashboard.

##  Team Dynamics
The team did a good job of distributing the workload; however, we faced difficulties transitioning from Python to R. As dash is relatively new (in R), the documentation and external resources were limited. Moreover, deployment on Heroku is not optimised for R, and it took a long time to decipher and debug the errors. 

## Current Limitations

- Some plots have limited interactivity; for instance we would like to link the map to different plots in the overview tab. 
- Linking plots with plotly was a task. We are identifying a right plot pairing to save the integrity
- We would like to implement an API instead of a static dataset to get insights on the impact of the pandemic on mental health

## Future Releases
- Allowing the user to plot trendlines and preform simple regression
- Adding in app help navigations
- Pointing users to additional resources such as research papers, news articles and journals.
