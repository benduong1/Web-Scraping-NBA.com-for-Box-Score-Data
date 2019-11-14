setwd("C:/Users/bpduong/Desktop/RStudio Analysis/NBA Data")

# install.packages("rjson")
# install.packages("sqldf")
install.packages("openxlsx")
# install.packages("tidyverse")
library(rjson)
library(sqldf)
library(openxlsx)
library(tidyverse)

all_years <- c(1983:2019)
# Creating avector to house all the years of NBA data

all_urls <- paste("https://stats.nba.com/stats/leaguegamelog?Counter=1000&Direction=DESC&LeagueID=00&PlayerOrTeam=P&Season=", all_years,"&SeasonType=Regular+Season&Sorter=PTS", sep = "")
# This vector houses all the links I need to use

box_scores <- data.frame()
# Creating adataframe for the box scores

for(i in 1:37) {
  box_scores_data <- fromJSON(file = all_urls[i], simplify = TRUE)
  # This houses the current for loop season box_scores
  # Only variable that changes in for loop
  # This is stored as a matrix
  # Will be taking the needed data and moving it to a data frame
  
  season_by_season <- data.frame(do.call(rbind, box_scores_data$resultSets[[1]]$rowSet))
  # Data frame that houses the box_score data by the season
  
  box_scores <- rbind(box_scores, season_by_season)
  # Rbinding so that all the seasons are added to a single data frame
}

colnames(box_scores) <- box_scores_data$resultSets[[1]]$headers
# Changing the column names to the correct names

colnames(box_scores) <- tolower(colnames(box_scores))
# Making the column names lowercase so they are easier to work with

length(unique(box_scores$season_id))
# Sanity check that all the seasons are in the data frame

box_scores <- as.matrix(box_scores)
# Need to convert dataframe into a matrix so that I can save it as a CSV

write.csv(box_scores, "all_box_scores.csv")
# Saving as a CSV file so we do not need to webscrape it anymore

box_scores <- read.csv("all_box_scores.csv")
# Importing the all_box_score CSV file
# If this is not done you cannot run dplyr through it
# Without importing the all_box_score data frame as a CSV R will treat all the dataframe's columns as list

##########################
# Now you have all the NBA's box score data from the 1984 season to 2019 season
# Have fun analyzing this rich pool of data



