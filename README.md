# WebApp_NBAStats

## **1. About this project**

Everything is explained in the pdf file named "ProjectReport". However, as it is written in French, this README file will explain the main points in English.  

We have at our disposal : 
  - An excel file **NBA_data_R** containing all the information of the NBA players
  - A **global** file that allows to define variables that can be used in both the server part and the interface part (renaming, package import, etc...)
  - A **server** file which will contain all the functions and actions proposed to the user (display, selection, etc...)
  - A **ui** file which simply allows to create the interface available to the user

This project was done in a school setting with another classmate. The subject was free.   
I had already built a database of NBA players with different statistics, we decided to re-use it to propose a visualization topic from this web app.

## **2. Origins and interests for the project**

Basketball, invented by James Naismith in 1891, is rapidly becoming more and more popular in North America. In 1949, the National Basketball Association (NBA) was born, which today is one of the four major leagues in American sports.   
We have an interest in sports and especially in the NBA. That's why we decided to study the salaries of the players according to their sports performances.

Seeing the astronomical salaries of many players, we asked ourselves for the data collection and storage project:  

**To what extent does the sports performance of the players affect their salary?**

Unfortunately, as a result of the health crisis, the **seasons were disrupted**, so we had to revert to a so-called "regular" year. Therefore, we will be looking at the **regular season for the 2018-2019 year**.

## **3. Our R-shiny web app**

The purpose of our application is to **display and study descriptive and sports statistics** related to players and teams.  
This will allow the user to have an idea of the capacities of the entities concerned with the **possibility to compare them and get an idea of the relative level between the players** and the prestige of a team. 
There are 4 pages in our application : 

  #### **1. Comparison between players**

The idea behind this first page is to **compare two players from a statistical point of view**.   
Of course, it is possible to select only one player to study only his performance. 
There are several charts:
  - A Kiviat diagram for the performances during an established match
  - A second Kiviat diagram for the performances established with percentages
  - A histogram that displays the salary associated with each player
  - Whisker boxes to position the players in relation to the globality of our of our data set

<div id="1st page" align = "center">
  <img src="https://user-images.githubusercontent.com/105392989/174280275-1b5ca6b7-c38f-4cc1-9b45-9d5105a88311.png" width="950">
</div>
  
  #### **2. Comparison between teams**
  
Now that we are interested in the players through the first page, we wanted to look at **statistics by comparing NBA teams**.  
For this we take the statistics of the players attached to the same team and we average each of the characteristics to have the same basis for
comparison. Of course this average thing is totally debatable but we didn't think of another category.

Our graph is a bubble chart that will position the teams in a space according to **two characteristics**. In parallel to the two characteristics, we give the user the possibility to **filter the teams** and all the teams that do not belong to the conditions of these filters will not be considered for the display.

<div id="2nd page" align = "center">
  <img src="https://user-images.githubusercontent.com/105392989/174280709-ab1cd432-2d62-4e72-bb4d-fdad8b48d9fc.png" width="950">
</div>

  #### **3. Data description**
  
This page does not offer many features.  
It simply allows the user to **get acquainted with the language and lexicon** used in the NBA world to define and categorize sports performances during different seasons.  
In reality, it is a simple **glossary**.

<div id="3rd page" align = "center">
  <img src="https://user-images.githubusercontent.com/105392989/174280808-ab3076cd-40ef-48ef-92e0-2a67a559ce67.png" width="950">
</div>

  #### **4. Introduction to the developers**
  
This last tab represents a **contact page**.   
Indeed, it allows us to present ourselves with a photo and an email address to _enter in contact if necessary_. Also, the **Linked profile** has been made available through a simple click.  
We also propose a OneDrive link to group all the elements that constitute this project (potentially closed since) 

<div id="4th page" align = "center">
  <img src="https://user-images.githubusercontent.com/105392989/174280863-c963fc69-ca22-4670-90d7-ecbfa5d9b6a8.png" width="950">
</div>

## **4. Ways to improve our project**

We are well aware that this project can be much more **driven and complete**. Here are some ideas on how to improve it:

  - Offer a part of **machine learning** with **supervised learning
  supervised** learning. 
  Indeed we have labeled data and a regression problem _(salary estimation)_. We can use linear regression as a learning model. To do so, we could have       **slightly restricted the number of characteristics** by focusing only on some of them like the number of wins, the number of points, the number of successful and attempted shots, etc...

  - **Diversify the analysis and possibilities by increasing the size of our data set**. 
  For this we could also have retrieved data from different seasons than this one, i.e. 2018-2019. This would have allowed us to **study and compare the evolution of players and teams**.

  - Retrieve a dataset containing **the position of the players on the field** during certain interventions (shots, passes, counter-attacks, etc...) to have **a visual map** as well as an idea of the distribution and positioning of the players during these actions

  - **Improve the graphical interface** by offering a more pleasant visual and more complete functionality

<div id="amelioration 1" align = "center">
  <img src="https://user-images.githubusercontent.com/105392989/174302175-d3fb50b4-f64f-465b-b512-34f326abfc6d.png" width="950">

  <img src="https://user-images.githubusercontent.com/105392989/174302220-1ab97572-be72-4651-a958-ff30352a6211.png" width="950">
  
  Source : https://toddwschneider.com/posts/ballr-interactive-nba-shot-charts-with-r-and-shiny/
</div>

<div id="amelioration 2" align = "center">
  <img src="https://user-images.githubusercontent.com/105392989/174302293-7ed3f208-06c5-4866-ab0d-39f7c8132124.png" width="950">
  
  Source : https://github.com/toddwschneider/ballr
</div>

Men lie but not numbers. The interpretation remains subjective.   
**So who do you think is better between Lebron and Curry?** 
