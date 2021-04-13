library(plotly)
library(scales)
library(shiny)
library(shinydashboard)
library(tidyverse)
library(lubridate)
library(zoo)
library(tidyr)
library(ggplot2)

data_covid <- read_csv("data/Indonesia.csv")

data_covid$Date <- dmy(data_covid$Date)
data_covid$Month <- month(data_covid$Date, label = T, abbr = F)
data_covid$Year <- year(data_covid$Date)
data_covid$month_year <- as.yearmon(data_covid$Date,"%m/%Y")

data_covid$Province <- as.factor(data_covid$Province)

pivot_covid <- pivot_longer(data = data_covid, cols = c("Cumulative_Recovered","Cumulative_Death"),
                            names_to = "ratio", values_to = "Nilai")

pivot_covid$ratio <- as.factor(pivot_covid$ratio)

str(pivot_covid)

