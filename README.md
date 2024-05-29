# Google-Capstone-Case-Study-Cyclistic-
Google Data Analytics Capstone Project: Case study: How does a bike-share navigate speedy success?
Case Study: How does a bike-share navigate speedy success?
Author: Omar Hamza.
Date: 29th May 2024.
Hi. I have enrolled in Google’s data analytics professional certificate course and this is my final phase of the program which is to conduct a capstone project. I have chosen the Cyclistic company’s case study which is a public dataset. 

In this case study, I analyzed the usage patterns of Cyclistic bike-share customers to understand the differences between casual riders and annual members. The primary objective was to gather insights that could inform marketing strategies aimed at converting casual riders into annual members, thereby enhancing Cyclistic's profitability and long-term growth. The process involved downloading and cleaning 12 months of historical trip data, followed by detailed analysis using descriptive statistics and visualizations. Key findings revealed that casual riders typically have longer ride durations and prefer weekend use, while annual members show more consistent usage throughout the week, particularly for commuting. Based on these insights, targeted marketing recommendations were developed to appeal to the distinct preferences of casual riders and encourage them to become annual members.
In this article I am going to write how I have conducted this case study This is my first project and I am very excited to complete this following the data analytics steps which are Ask, Prepare, Process, Analyze, Share and Act.

# Scenario
Cyclistic is a bike share company operating in a major city. Since its inception, Cyclistic has experienced significant growth, offering a fleet of thousands of bicycles available for short-term rentals across the city. The service provides a flexible and eco-friendly transportation option for both residents and tourists. Cyclistic operates on a membership model, offering both annual memberships and casual passes for single rides or daily use.
In this scenario, I am a junior data analyst on the marketing analytics team at Cyclistic, a bike-share company based in Chicago, I have been tasked with a project. Our director of marketing believes that the future success of our company hinges on maximizing the number of annual memberships. To achieve this, I have given a task to find out how casual riders and annual members use Cyclistic bikes differently.

Ask
In this phase, I am going to identify the business task and consider the key stakeholders
Statement of the Business Task:
The business task is to understand how annual members and casual riders use Cyclistic bikes differently. This insight will help design marketing strategies to convert casual riders into annual members, increasing Cyclistic's profitability and long-term growth.
Key stakeholders:
* Lily Moreno (Director of Marketing team), 
* Marketing Analytics Team,
* Cyclistic Executive Team.

Prepare
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






```r


```








