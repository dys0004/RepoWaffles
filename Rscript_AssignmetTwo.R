#Create a vector named 'z' with 200 z values
z <- c(1:200)
#Print the mean and standard deviation of z on the console
mean(z)
sd(z)

#Create a logical vector that is 'TRUE' for z values that are greater than 1 
z > 1 


#Make a dataframe with z and your new logical vector as columns. 
z_df <- data.frame(c(1:200),
                   c(z > 1))

#Change the column names in your new dataframe to equal “z” and “zlog”
z_df <- data.frame("z" = c(1:200),
                   "zlog" = c(z > 1))

#Make a new column in your dataframe equal to z squared (i.e., z2)... 
#   Call the new column zsquared. 
z_df <- data.frame("z" = c(1:200),
                   "zlog" = c(z > 1),
                   "zsquared" = c(z^2))

#Subset zsquared column 
z_df[,"zsquared"]

#Subsetted data with only values greater than 10
new_z_df <- subset(z_df, zsquared >10, 
                  select = c(zsquared))

#Install the following packages...
# and show me, using code, that they are installed, and you can use them. 

install.packages("ggplot2")
install.packages("dplyr")
install.packages("purrr")
install.packages("lme4")
install.packages("emmeans")

library(ggplot2)
library(dplyr)
library(purrr)
library(lme4)
library(emmeans)

#Download the Tips.csv file from canvas 
#Use the read.csv() function...
#to read the data into R so that the missing values are properly coded
datum <- read.csv("TipsR.csv", na.strings = NA)

