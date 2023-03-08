# install package 
install.packages("gglot2")
#load library 
library(ggplot2)

# Practice dataset for take home midterm 
data("ChickWeight")
# preview of data 
head(ChickWeight)

# layering using "geom" functions
ggplot(data = ChickWeight,aes(x=Time, y=weight, group=Chick, color=Diet)) +
  geom_line() +
  geom_point()

# Adding Scales 
ggplot(data = ChickWeight,aes(x=Time, y=weight, group=Chick, color=Diet)) +
  geom_line() +
  geom_point() +
  scale_x_continuous(name="Time(Days Post Birth)", limits=c(0, 20))+
  scale_y_continuous(name="Body weight (gm)", limits=c(0, 400)) 

# adding minimalist theme 
ggplot(data = ChickWeight,aes(x=Time, y=weight, group=Chick, color=Diet)) +
  geom_line() +
  geom_point() +
  scale_x_continuous(name="Time(Days Post Birth)", limits=c(0, 20))+
  scale_y_continuous(name="Body weight (gm)", limits=c(0, 400)) +
  theme_minimal()

# adding facets
ggplot(data = ChickWeight,aes(x=Time, y=weight, group=Chick, color=Diet)) +
  geom_line() +
  scale_x_continuous(name="Time(Days Post Birth)", limits=c(0, 20))+
  scale_y_continuous(name="Body weight (gm)", limits=c(0, 400)) +
  facet_grid(cols = vars(Diet), labeller = label_both) 

# Question 5
#load dplyr package 
library(dplyr)

data("ToothGrowth")
df <- data.frame (ToothGrowth)
#Preview the dataframa 
head(df)
#Subset ToothGrowth to include rows such that supp is equal to VC
VC_only <- df %>% filter(supp == "VC" )
#Preview the data
VC_only

#Subset ToothGrowth to include rows such that supp is equal to VC and dose is equal to 0.5
VCDose <-VC_only %>% filter(dose == "0.5" )
#Preview the data
VCDose

#Subset ToothGrowth to include the values of len such that supp is equal to VC and dose is equal to 0.5
VCDose_len <- VCDose %>% select('len')

#Preview the data
VCDose_len
