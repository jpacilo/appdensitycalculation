# Using the population.csv and regionarea.csv files, calculate the population density (persons per square km) of all barangays in the Philippines.
# However, since only areas for regions are provided (in square kilometers), assume that the barangays in a particular region will have equal land area. (E.g. Area of Barangay in Region 1 = Area of Region 1/Number of Barangays in Region 1)
# The R Code should be able to output a CSV file that lists down the top 5 barangays with the highest densities.

Brgy = read.csv("population.csv")
View(Brgy)
Region = read.csv("regionarea.csv")
View(Region)

library(sqldf)

total <- sqldf("select * from Region inner join Brgy on Region.Region = Brgy.Region")
View(total)
