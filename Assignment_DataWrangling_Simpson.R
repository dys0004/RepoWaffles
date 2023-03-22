#Data wrangling in R – 50 pts
#This assignment will let you practice the functions 
#presented in the data wrangling module. 

# install packages 
#install.packages("tidyverse")

# Load packages 
library(tidyverse)
library(dplyr)

# for some reason filter options doesn't work 
detach("package:dplyr")
library(dplyr)


 # Set working directory 
#setwd("/Users/dasiasimpson/Desktop/Spring 2023/Reproducible_Data_Spr2023/Data_Wrangle/Data_Wrangling")

# Read in data 
MicroBiome_1 <-read.csv("Microbiome.csv")

#Q1. Select the following columns.
#OTU, SampleID, Abundance, Crop, Compartment, 
#DateSampled, GrowthStage, Treatment, Rep, Fungicide, 
# Kingdom, Phylum, Class, Order, Family, Genus, Species, Taxonomy

# select function choose columns of your choosing 
# Put relevant columns into MB_2 object 
MB2 <- select(MicroBiome_1,OTU, SampleID, Abundance, Crop, 
                 Compartment, DateSampled, GrowthStage, 
                 Treatment, Rep, Fungicide, Kingdom, Phylum,
                 Class, Order, Family, Genus, Species, Taxonomy)


#Q2. Calculate the mean percent relative abundance 
# across all OTUs by compartment using the pipe operator.
MB2 %>%
  select(OTU, SampleID, Abundance, Crop, 
         Compartment, DateSampled, GrowthStage, 
         Treatment, Rep, Fungicide, Kingdom, Phylum,
         Class, Order, Family, Genus, Species, Taxonomy)%>%
  group_by(Compartment) %>%
  dplyr::mutate(Percent = Abundance*100) %>%
  summarise(Mean = mean(Percent))
 
#Q3. Calculate the mean percent relative abundance
#across all OTUs by compartment and fungicide using the pipe operator.
MB2 %>%
  select(OTU, SampleID, Abundance, Crop, 
         Compartment, DateSampled, GrowthStage, 
         Treatment, Rep, Fungicide, Kingdom, Phylum,
         Class, Order, Family, Genus, Species, Taxonomy)%>%
  group_by(Compartment,Fungicide) %>%
  mutate(Percent = Abundance*100) %>%
  summarise(Mean = mean(Percent))



# Does this filter ?
# Q4. Restrict the previous analysis to just the fungal class Dothideomycetes.
MB3 <- MB2 %>%
  select(OTU, SampleID, Abundance, Crop, 
         Compartment, DateSampled, GrowthStage, 
         Treatment, Rep, Fungicide, Kingdom, Phylum,
         Class, Order, Family, Genus, Species, Taxonomy)%>%
  filter(Class == "Dothideomycetes")%>%
  group_by(Compartment,Fungicide) %>%
  mutate(Percent = Abundance*100) %>%
  mutate(Mean = mean(Percent))


#need help did i do this right 
# Q5. Now do the same analysis but for Orders in the genus Dothideomycetes.
MB3 %>%
  select(OTU, SampleID, Abundance, Crop, 
         Compartment, DateSampled, GrowthStage, 
         Treatment, Rep, Fungicide, Kingdom, Phylum,
         Class, Order, Family, Genus, Species, Taxonomy)%>%
  filter(Class == "Dothideomycetes")%>%
  group_by(Order) %>%
  mutate(Percent = Abundance*100) %>%
  mutate(Mean = mean(Percent))


# Q6 Calculate the standard error for each mean in Q5.

MB3 %>%
  select(OTU, SampleID, Abundance, Crop, 
         Compartment, DateSampled, GrowthStage, 
         Treatment, Rep, Fungicide, Kingdom, Phylum,
         Class, Order, Family, Genus, Species, Taxonomy)%>%
  filter(Class == "Dothideomycetes")%>%
  group_by(Order) %>%
  mutate(Percent = Abundance*100) %>%
  summarise(Mean = mean(Percent), 
            n = n(), 
            sd.dev = sd(Percent)) %>%
  mutate(std.err = sd.dev/sqrt(n))


#Need Help 
#  Q7 Select the columns Order, Compartment, Fungicide and Mean from the output of Q6 and 
# Pivot the dataset to wide format so you have Compartment as column headers

MB3 %>%
  filter(Class == "Dothideomycetes")%>%
  group_by(Order,Compartment,Fungicide) %>%
  mutate(Percent = Abundance*100) %>%
  summarise(Mean = mean(Percent), 
            n = n(), 
            sd.dev = sd(Percent)) %>%
  mutate(std.err = sd.dev/sqrt(n)) %>%
  select(Order,Compartment,Fungicide,Mean)%>%
  pivot_wider(names_from = Compartment, values_from = Mean)



# Q8. Recreate plot (from Word document using your dataset in Q7. 


MB3 %>%
  filter(Class == "Dothideomycetes")%>%
  group_by(Order,Compartment,Fungicide) %>%
  mutate(Percent = Abundance*100) %>%
  summarise(Mean = mean(Percent), 
            n = n(), 
            sd.dev = sd(Percent)) %>%
  mutate(std.err = sd.dev/sqrt(n)) %>%
  select(Order,Compartment,Fungicide,Mean)%>%
  pivot_wider(names_from = Compartment, values_from = Mean) %>%
  ggplot(aes(x = reorder(Order, +Leaf), y = Leaf, fill = Fungicide)) +
  geom_bar(position="dodge",stat="identity") +
  coord_flip() 


MB3 %>%
  filter(Class == "Dothideomycetes")%>%
  group_by(Order,Compartment,Fungicide) %>%
  mutate(Percent = Abundance*100) %>%
  summarise(Mean = mean(Percent), 
            n = n(), 
            sd.dev = sd(Percent)) %>%
  mutate(std.err = sd.dev/sqrt(n)) %>%
  select(Order,Compartment,Fungicide,Mean)%>%
  pivot_wider(names_from = Compartment, values_from = Mean) %>%
  ggplot(aes(x = reorder(Order, +Root), y = Root, fill = Fungicide)) +
  geom_bar(position="dodge",stat="identity") +
  coord_flip() 

  
   
  