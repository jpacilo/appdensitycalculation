# Using the population.csv and regionarea.csv files, calculate the population density of all Cities in the Philippines.
# However, since only areas for regions are provided (in square kilometers), assume that all cities in a particular region will have equal land area. (E.g. Area of City in Region 1 = Area of Region 1/Number of Cities in Region 1)
# The R Code should be able to output a CSV file that lists down the top 5 cities with the highest densities.

regionarea <- read.csv("regionarea.csv")
population <- read.csv("population.csv")



#Area per Distinct CityProvince
library("sqldf")
AreaPerCityProvince = sqldf("SELECT population.Region, Count(Distinct population.CityProvince),
                regionarea.Area / Count(Distinct population.CityProvince) AS AreaperCity
                
                FROM population
                
                INNER JOIN regionarea ON population.region = regionarea.region
                GROUP BY population.Region
                ")
View(AreaPerCityProvince)



#Total Population per CityProvince
library("sqldf")
SumPopCityProv <- sqldf("SELECT population.Region, population.Province, population.CityProvince,
                            SUM(population.population) AS TotalPop
                          
                            FROM population
                            
                            GROUP BY population.CityProvince
                            ;")
View(SumPopCityProv)



#Population Density per CityProvince
library("sqldf")
CityDensity <- sqldf("SELECT SumPopCityProv.Region, SumPopCityProv.Province, SumPopCityProv.CityProvince, 
                            SumPopCityProv.TotalPop/AreaPerCityProvince.AreaperCity AS PopDen
                            
                            FROM SumPopCityProv
                            
                            INNER JOIN AreaPerCityProvince ON SumPopCityProv.region = AreaPerCityProvince.region
                            GROUP BY SumPopCityProv.CityProvince
                            ORDER BY PopDen DESC
                            limit 5
                            ;")
View(CityDensity)


write.csv(CityDensity, file = "CityDensity.csv") 
