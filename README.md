# Google-Capstone-Case-Study-Cyclistic BIKE-SHARE 
### Google Data Analytics Capstone Project: Case study: How does a bike-share navigate speedy success?
### Case Study: How does a bike-share navigate speedy success?
### Author: Omar Hamza.
### Date: 30th May 2024.
### Hi. I have enrolled in Google’s data analytics professional certificate course and this is my final phase of the program which is to conduct a capstone project. I have chosen the Cyclistic company’s case study which is a public dataset. 

In this case study, I analyzed the usage patterns of Cyclistic bike-share customers to understand the differences between casual riders and annual members. The primary objective was to gather insights that could inform marketing strategies aimed at converting casual riders into annual members, thereby enhancing Cyclistic's profitability and long-term growth. The process involved downloading and cleaning 12 months of historical trip data, followed by detailed analysis using descriptive statistics and visualizations. Key findings revealed that casual riders typically have longer ride durations and prefer weekend use, while annual members show more consistent usage throughout the week, particularly for commuting. Based on these insights, targeted marketing recommendations were developed to appeal to the distinct preferences of casual riders and encourage them to become annual members.
In this article I am going to write how I have conducted this case study This is my first project and I am very excited to complete this following the data analytics steps which are Ask, Prepare, Process, Analyze, Share and Act.

# Scenario
Cyclistic is a bike share company operating in a major city. Since its inception, Cyclistic has experienced significant growth, offering a fleet of thousands of bicycles available for short-term rentals across the city. The service provides a flexible and eco-friendly transportation option for both residents and tourists. Cyclistic operates on a membership model, offering both annual memberships and casual passes for single rides or daily use.
In this scenario, I am a junior data analyst on the marketing analytics team at Cyclistic, a bike-share company based in Chicago, I have been tasked with a project. Our director of marketing believes that the future success of our company hinges on maximizing the number of annual memberships. To achieve this, I have given a task to find out how casual riders and annual members use Cyclistic bikes differently.

#Ask
In this phase, I am going to identify the business task and consider the key stakeholders
Statement of the Business Task:
The business task is to understand how annual members and casual riders use Cyclistic bikes differently. This insight will help design marketing strategies to convert casual riders into annual members, increasing Cyclistic's profitability and long-term growth.
Key stakeholders:
* Lily Moreno (Director of Marketing team), 
* Marketing Analytics Team,
* Cyclistic Executive Team.

#Prepare
In this stage, I am going to identify the data which I am going to use for the task and create a description of it.
Description of Data Sources:
The data used for this analysis consists of Cyclistic's historical bike trip data over the last 12 months. This public dataset includes information about individual rides such as start time, end time, duration, starting station, ending station, and rider type (casual or member). The data is provided by Motivate International Inc. under a public [license](https://divvybikes.com/data-license-agreement).


# Process
*  Download and load data: Since I need to use the previous 12 months of data seta, I am going to use data from May 2023 till April 2024. I am going to download and look into the data set and find out which data I will be using and which not.
* Data cleaning: First I have created a column which will show the day name which later will be usefull for analyzing. I order to do that I have used =Text(D2,”dddd”) formula and where C2 is the started_at column.

  ![Adding day in excel](https://github.com/omarhamza1996/Google-Capstone-Case-Study-Cyclistic-/blob/main/Screenshots/day.png)

In the same way, I have created another column named Month and sorted out the months of each cell.
  ![Adding day month excel](https://github.com/omarhamza1996/Google-Capstone-Case-Study-Cyclistic-/blob/main/Screenshots/month.png)

Later I need to find the duration in minutes between the starting date and time and the ending date and time of the ride. To find it I used =(E2-C2)*1440 which finds the difference between end time and start time and by multiplying with 1440 by which I were able to find exact minutes.

![Adding time duration excel](https://github.com/omarhamza1996/Google-Capstone-Case-Study-Cyclistic-/blob/main/Screenshots/minutes.png)

I did it to all 12 months of the dataset. To get a clean data I removed start_station_id,end_station_id,start_lat, and end_lat which will not be needed for my calculation.
The only thing left to clean the data properly is to remove the data row which has missing values.
So I moved all the data to R studio where I will conduct the rest of the analyzing process.
I loaded all the data in R and call out tidyverse and dplyr,readr and skimr pacakage for merging and analyzing.

```r

library(tidyverse)
library(dplyr)
library(readr)
library(skimr)

April24 <- read_csv("Case Study/Excel file for cleaning/April24.csv")
March24 <- read_csv("Case Study/Excel file for cleaning/March24.csv")
February24 <- read_csv("Case Study/Excel file for cleaning/February24.csv")
January24 <- read_csv("Case Study/Excel file for cleaning/January24.csv")
December23 <- read_csv("Case Study/Excel file for cleaning/December23.csv")
November23 <- read_csv("Case Study/Excel file for cleaning/November23.csv")
October23 <- read_csv("Case Study/Excel file for cleaning/October23.csv")
September23 <- read_csv("Case Study/Excel file for cleaning/September23.csv")
August23 <- read_csv("Case Study/Excel file for cleaning/August23.csv")
July23 <- read_csv("Case Study/Excel file for cleaning/July23.csv")
June23 <- read_csv("Case Study/Excel file for cleaning/June23.csv")
May23 <- read_csv("Case Study/Excel file for cleaning/May23.csv")

```

After that  cloname() and str() functins were used to look at the data and type



```r
colnames(April24)
colnames(March24)
colnames(February24)
colnames(January24)
colnames(December23)
colnames(November23)
colnames(October23)
colnames(September23)
colnames(August23)
colnames(July23)
colnames(June23)
colnames(May23)

str(April24)
str(March24)
str(February24)
str(January24)
str(December23)
str(November23)
str(October23)
str(September23)
str(August23)
str(July23)
str(June23)
str(May23)

```



After that, I merged the 12 months dataset


```r
# merging all 12 months of data
bike_data <- rbind(April24,March24,February24,January24,December23,November23,
                          October23,September23,August23,July23,June23,May23)
dim(bike_data)

```
After merging the final step of cleaning is to remove the rows which has blank cell

```r

#cleaning the rows which have empty cells

merged_bike_data <- na.omit(bike_data)
```

And my data is ready for analysis.
# Analyze
* Finding out the total duration and total amount of rides based on member or casual riders.

```r
# finding the total number of rider based on membership

total_ride <- merged_bike_data %>% 
  group_by(member_casual) %>% 
  summarize(n_distinct(ride_id))

view(total_ride)

# Calculating average bike ride duration,minimum and maximum duration

rider_mean_ride <- merged_bike_data %>% 
  group_by(member_casual) %>% 
  summarize(agerage_ride_duration = mean(duration_minutes),minimum_ride_duration = min(duration_minutes),
            maximum_duration = max(duration_minutes))


```
* Finding out the total number of riders, duration and average time based on days of the week 



```r
#riders ride and their total and average duration during each day of the week

ride_based_on_week <- merged_bike_data %>% 
  group_by(member_casual,start_day) %>% 
  summarize(total_riders =n(), .groups = 'drop' ,total_duration= sum(duration_minutes),
            average_duration= mean(duration_minutes))
view(ride_based_on_week)

```


* Finding out the total number of riders, duration and average time based on each month

```r

# ride number,average and total and duration based on month

ride_based_on_month <- merged_bike_data %>% 
  group_by(month,member_casual) %>% 
  summarize(total_riders =n_distinct(ride_id) ,total_duration= sum(duration_minutes),
            average_duration= mean(duration_minutes))

View(ride_based_on_month)

```
* Total riders, total duration based on different types of bike
```r
ridable_bike_type <- merged_bike_data %>% 
  group_by(member_casual,rideable_type) %>% 
  summarize(Number_of_riders=n_distinct(ride_id),total_duration= sum(duration_minutes),
            average_duration=mean(duration_minutes))
View(ridable_bike_type)

```
* Top 5 popular start stations

```r
start_stations <- merged_bike_data %>%
  group_by(start_station_name,member_casual,ride_id) %>%
  summarise(total_rides = n())
  
view(start_stations)

```
Visualization
For visualization in R, I used the Ggplot2 package and called the library


```r
library(ggplot2)
library(scales)

```
* Pie chart for the total of rides based on member or casual riders.

```r
#Pie chart showing the difference between total riders


ggplot(total_ride, aes(x = "", y = ride, fill = member_casual)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  geom_text(aes(label = total_rides), 
            position = position_stack(vjust = 0.5)) +
  labs(title = "Rides by Member Type",
       fill = "Rider Type") +
  theme_void()

```
 ![Pie chart](https://github.com/omarhamza1996/Google-Capstone-Case-Study-Cyclistic-/blob/main/Screenshots/Pie%20chart.jpeg)

*  Bar diagram showing number of riders based on month

```r
ggplot(ride_based_on_month, aes(x = month, y = total_riders, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "       Total Rides based on months",x = "Month",y = "Total Rides",
       fill = "Rider Type") +
  scale_y_continuous(labels = comma) +
  theme_minimal()
```
![Number of riders by month](https://github.com/omarhamza1996/Google-Capstone-Case-Study-Cyclistic-/blob/main/Screenshots/total_ride%20based%20on%20month.jpeg)

* Bar diagram showing average ride duration based on month
```r
ggplot(ride_based_on_month, aes(x = month, y = average_duration, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "       Average duration riders ride based on months",x = "Month",y = "Minutes",
       fill = "Rider Type") +
  scale_y_continuous(labels = comma) +
  theme_minimal()
```
![average duration](https://github.com/omarhamza1996/Google-Capstone-Case-Study-Cyclistic-/blob/main/Screenshots/Average%20duration%20based%20on%20months.jpeg)

* •	Bar diagram showing the number of riders based on weekdays.

```r
#3 total rides based on days


ggplot(ride_based_on_week, aes(x = start_day, y = total_riders, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "       Total Rides based on days",x = "Day",y = "Total Rides",
       fill = "Rider Type") +
  scale_y_continuous(labels = comma) +
  theme_minimal()
```
![Bar diagram](https://github.com/omarhamza1996/Google-Capstone-Case-Study-Cyclistic-/blob/main/Screenshots/total%20ride%20based%20on%20days.jpeg)

* Bar diagram showing average ride duration based on days
```r
#4 average duration based on days

ggplot(ride_based_on_week, aes(x = start_day, y = average_duration, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "       Average duration riders ride based on days",x = "Day",y = "Minutes",
       fill = "Rider Type") +
  scale_y_continuous(labels = comma) +
  theme_minimal()

```
![Bar diagram](https://github.com/omarhamza1996/Google-Capstone-Case-Study-Cyclistic-/blob/main/Screenshots/average%20duration%20ased%20on%20days.jpeg)

* Bar diagram showing the total number of riders based on different bikes.

```r
ggplot(ride_based_on_week, aes(x = start_day, y = total_riders, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "       Total Rides based on days",x = "Day",y = "Total Rides",
       fill = "Rider Type") +
  scale_y_continuous(labels = comma) +
  theme_minimal()

```
![Bar diagram](https://github.com/omarhamza1996/Google-Capstone-Case-Study-Cyclistic-/blob/main/Screenshots/rides%20based%20on%20different%20type%20of%20bike.jpeg)

# Share

After analyzing the data, I am going to share the insights which I have found during the analysis. The chart was generated in Microsoft Excel.

* Average ride duration in minutes between members and casual riders.

![Bar diagram](https://github.com/omarhamza1996/Google-Capstone-Case-Study-Cyclistic-/blob/main/Data%20Visualisation/Average%20duration%20based%20on%20members%20and%20casual.png)


* Total number of riders 

![Pie Chart](https://github.com/omarhamza1996/Google-Capstone-Case-Study-Cyclistic-/blob/main/Data%20Visualisation/total%20rides%20based%20on%20member%20and%20casuals.png)

* Total ride duration.
![Ride duration](https://github.com/omarhamza1996/Google-Capstone-Case-Study-Cyclistic-/blob/main/Data%20Visualisation/Total%20ride%20duration.png)

* Number of riders using different types of bikes.
![bar](https://github.com/omarhamza1996/Google-Capstone-Case-Study-Cyclistic-/blob/main/Data%20Visualisation/Different%20bike%20type.png)

* Total number of riders based on months
![bar](https://github.com/omarhamza1996/Google-Capstone-Case-Study-Cyclistic-/blob/main/Data%20Visualisation/Riders%20ride%20based%20on%20month.png)

* 	Average ride duration based on months

![bar](https://github.com/omarhamza1996/Google-Capstone-Case-Study-Cyclistic-/blob/main/Data%20Visualisation/Average%20riding%20time%20based%20on%20month.png)

* Total number of riders based on days of the week over 12 months
![bar](https://github.com/omarhamza1996/Google-Capstone-Case-Study-Cyclistic-/blob/main/Data%20Visualisation/Riders%20ride%20based%20on%20days.png)

* Top 5 popular stations
![bar](https://github.com/omarhamza1996/Google-Capstone-Case-Study-Cyclistic-/blob/main/Data%20Visualisation/Top%205%20stations.png)

# Findings
Based on the report and the diagrams my key findings are:
* The company’s 35% of the users are casual riders but their duration is 188% higher than members which will be a very profitable decision by converting them into members.
* Most of the casual riders use bike-share during weekends which indicates they tend to use it for leisure.
* The usage of casual riders is higher from June to August due to warm weather.
*	Causal riders often use docked bikes compared to members who do not use them.
# Act
Based on the observations and findings the recommendations are:
* Marketing such as social marketing, advertisement should start in early May because the of casual riders using bike-share increases from that time and it would create a brand image early of peak usage.
* The price of per-minute usage should be increased slightly for casual riders during summer so that they would be attracted to purchase memberships.
* Discounts and promotional offers should be implied such as the first 30 minutes being free if casual riders switch to members.
* Promotional activities should be high in Streeter Dr & Grand Ave,DuSable Lake Shore Dr & Monroe St,Michigan Ave & Oak St,DuSable Lake Shore Dr & North Blvd,Kingsbury St & Kinzie St should be increased as they are the hottest spot for riders to start their ride.


### Reference
* https://googledataanalytics.wordpress.com/how-does-a-bike-share-navigate-speedy-success/


#### Thank you so much for taking the time to read it. Your feedack would be much appreciated.


























