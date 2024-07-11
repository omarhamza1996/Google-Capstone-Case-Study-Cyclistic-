library(tidyverse)
library(readr)
library(janitor)
library(skimr)
library(ggplot2)
library(scales)
library(openxlsx)
library(dplyr)


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

#Checking column and data structure

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

# merging all 12 months of data

bike_data <- rbind(April24,March24,February24,January24,December23,November23,
                          October23,September23,August23,July23,June23,May23)
dim(bike_data)

#cleaning the rows which has empty cells

merged_bike_data <- na.omit(bike_data)


# Calculating average bike ride duration,minimum and maximum duration

rider_mean_ride <- merged_bike_data %>% 
  group_by(member_casual) %>% 
  summarize(agerage_ride_duration = mean(duration_minutes),minimum_ride_duration = min(duration_minutes),
            maximum_duration = max(duration_minutes))

View(rider_mean_ride)


# finding the total number of rider based on membership

total_ride <- merged_bike_data %>% 
  group_by(member_casual) %>% 
  summarize(n_distinct(ride_id))


view(total_ride)
# finding total duration between members and casual riders

total_ride_time <- merged_bike_data %>% 
  group_by(member_casual) %>% 
  summarize(total_ride_duration= sum(duration_minutes))
View(total_ride_time)

# ride number,average and total and duration based on month

ride_based_on_month <- merged_bike_data %>% 
  group_by(month,member_casual) %>% 
  summarize(total_riders =n_distinct(ride_id) ,total_duration= sum(duration_minutes),
            average_duration= mean(duration_minutes))

View(ride_based_on_month)



#riders ride and their total and average duration during each day of the week

ride_based_on_week <- merged_bike_data %>% 
  group_by(member_casual,start_day) %>% 
  summarize(total_riders =n(), .groups = 'drop' ,total_duration= sum(duration_minutes),
            average_duration= mean(duration_minutes))
view(ride_based_on_week)


# riders based on different bike types

ridable_bike_type <- merged_bike_data %>% 
  group_by(member_casual,rideable_type) %>% 
  summarize(Number_of_riders=n_distinct(ride_id),total_duration= sum(duration_minutes),
            average_duration=mean(duration_minutes))
View(ridable_bike_type)


# 5 popular stations

start_stations <- merged_bike_data %>%
  group_by(start_station_name,member_casual,ride_id) %>%
  summarise(total_rides = n())

view(start_stations)



# data visualization


#1 total trips based on month

ggplot(ride_based_on_month, aes(x = month, y = total_riders, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "       Total Rides based on months",x = "Month",y = "Total Rides",
       fill = "Rider Type") +
  scale_y_continuous(labels = comma) +
  theme_minimal()

#2 average duration based on month

ggplot(ride_based_on_month, aes(x = month, y = average_duration, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "       Average duration riders ride based on months",x = "Month",y = "Minutes",
       fill = "Rider Type") +
  scale_y_continuous(labels = comma) +
  theme_minimal()


#3 total rides based on days


ggplot(ride_based_on_week, aes(x = start_day, y = total_riders, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "       Total Rides based on days",x = "Day",y = "Total Rides",
       fill = "Rider Type") +
  scale_y_continuous(labels = comma) +
  theme_minimal()


#4 average duration based on days

ggplot(ride_based_on_week, aes(x = start_day, y = average_duration, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "       Average duration riders ride based on days",x = "Day",y = "Minutes",
       fill = "Rider Type") +
  scale_y_continuous(labels = comma) +
  theme_minimal()

#5 Rides based on different type of bike


ggplot(ridable_bike_type, aes(x = rideable_type, y = Number_of_riders, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "       Total Rides based on different bikes",x = "Bike Type",y = "Total Rides",
       fill = "Rider Type") +
  scale_y_continuous(labels = comma) +
  theme_minimal()

#6 Pie chart showing the difference between total riders


ggplot(total_ride, aes(x = "", y = ride, fill = member_casual)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  geom_text(aes(label = ride), 
            position = position_stack(vjust = 0.5)) +
  labs(title = "Rides by Member Type",
       fill = "Rider Type") +
  theme_void()




