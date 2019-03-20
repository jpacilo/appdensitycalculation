---
title: "App Density Calculation"
output: html_document
---

```{r}
library(dplyr)
```

```{r}
region_area <- read.csv("regionarea.csv")
population <- read.csv("population.csv")
innerjoin <- merge(x = population, y = region_area, by = c("Region"))
```

```{r}
main <- region_area
main$count <- unlist(lapply(1:18, function(x) nrow(filter(innerjoin, Region == region_area$Region[x]))))
```

```{r}
main$area_per_barangay <- main$Area / main$count 
```

```{r}
main <- mutate(main, area_per_barangay = Area / count)    
main <- merge(x = population, y = main, by = c("Region")) 
```

```{r}
main <- mutate(main, population_density = Population / area_per_barangay)
main <- arrange(main, desc(population_density))[1:5,]
```
```{r}
write.csv(main, file = "BarangayDensity.csv") 
```
