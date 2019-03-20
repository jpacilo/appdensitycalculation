## Barangay Density

### Load pkg 
First, we need to load the dplyr package for the pre-made functions
```{r}
library(dplyr)
```

### Merge
Next, we read the 'regionarea.csv' and the 'population.csv' using the read.csv function in R.
Then we merged the two dataframes using the merge function in R.
The region is the common column between the two dfs in order to merge them.
```{r}
region_area <- read.csv("regionarea.csv")
population <- read.csv("population.csv")
innerjoin <- merge(x = population, y = region_area, by = c("Region"))
```

### Aggregate 
We initialized a new variable main.
We count the number of barangays per region using the lapply function and aggregated them by region.
The 1 to 18 index is derived from the rows of the region_area dataframe.
The output of the lapply function is a list so we performed the unlist function afterwards.
```{r}
main <- region_area
main$count <- unlist(lapply(1:18, function(x) nrow(filter(innerjoin, Region == region_area$Region[x]))))
```

### Merge
Then we added a column named area_per_barangay by dividing the Area to count.
Then we merged the population and main dfs by the common field region
```{r}
main <- mutate(main, area_per_barangay = Area / count)    
main <- merge(x = population, y = main, by = c("Region")) 
```

### Mutate
Next, we added a column population_density by dividing the value of Population to the area_per_barangay
Then we arranged the df in descending order, and displayed only the top 5.
```{r}
main <- mutate(main, population_density = Population / area_per_barangay)
main <- arrange(main, desc(population_density))[1:5,]
```

# Write
We used the write.csv function to write out the result of main.
```{r}
write.csv(main, file = "BarangayDensity.csv") 
```
