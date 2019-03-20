# Using the population.csv and regionarea.csv files, calculate the population density (persons per square km) of all barangays in the Philippines.
# However, since only areas for regions are provided (in square kilometers), assume that the barangays in a particular region will have equal land area. (E.g. Area of Barangay in Region 1 = Area of Region 1/Number of Barangays in Region 1)
# The R Code should be able to output a CSV file that lists down the top 5 barangays with the highest densities.

library(dplyr)

region_area <- read.csv("regionarea.csv")
population <- read.csv("population.csv")
innerjoin <- merge(x = population, y = region_area, by = c("Region"))

main <- region_area
main$count <- barangay_count <- unlist(lapply(1:18, function(x) nrow(filter(innerjoin, Region == region_area$Region[x]))))
main$area_per_barangay <- main$Area / main$count 

main <- mutate(main, area_per_barangay = Area / count)    
main <- merge(x = population, y = main, by = c("Region")) 
main <- mutate(main, population_density = Population / area_per_barangay)
main <- arrange(main, desc(population_density))[1:5,]

write.csv(main, file = "BarangayDensity.csv")   
