/*
You'll now try to figure out which countries had high average life expectancies (at the country level) in 2015.
*/

/*
Instructions 1/2
Begin by calculating the average life expectancy across all countries for 2015.
*/
SELECT AVG(life_expectancy)
FROM populations
WHERE year = 2015;

/*
Instructions 2/2
Recall that you can use SQL to do calculations for you. Suppose we wanted only records that were above 1.15 * 100 in terms of life expectancy for 2015:
SELECT *
FROM populations
WHERE life_expectancy > 1.15 * 100
  AND year = 2015;
Select all fields from populations with records corresponding to larger than 1.15 times the average you calculated in the first task for 2015. In other words, change the 100 in the example above with a subquery.
*/
SELECT *
FROM populations
WHERE life_expectancy > 1.15 *
    (SELECT AVG(life_expectancy)
    FROM populations
    WHERE year = 2015)
    AND year = 2015;

/*
Use your knowledge of subqueries in WHERE to get the urban area population for only capital cities.
*/

/*
Instructions
Make use of the capital field in the countries table in your subquery.
Select the city name, country code, and urban area population fields.
*/
SELECT city.name, city.country_code, city.urbanarea_pop
-- from the cities table
FROM cities AS city
-- with city name in the field of capital cities
WHERE city.name IN
  (SELECT capital
   FROM countries)
ORDER BY urbanarea_pop DESC;

/*
In this exercise, you'll see how some queries can be written using either a join or a subquery.
You have seen previously how to use GROUP BY with aggregate functions and an inner join to get summarized information from multiple tables.
The code given in query.sql selects the top nine countries in terms of number of cities appearing in the cities table. Recall that this corresponds to the most populous cities in the world. Your task will be to convert the commented out code to get the same result as the code shown.
*/

/*
Instructions 1/2
Just Submit Answer here!
*/

SELECT countries.name AS country, COUNT(*) AS cities_num
FROM cities
INNER JOIN countries
ON countries.code = cities.country_code
GROUP BY country
ORDER BY cities_num DESC, country
LIMIT 9;

/*
Instructions 2/2
Remove the comments around the second query and comment out the first query instead.
Convert the GROUP BY code to use a subquery inside of SELECT, i.e. fill in the blanks to get a result that matches the one given using the GROUP BY code in the first query.
Again, sort the result by cities_num descending and then by country ascending.
*/
SELECT countries.name AS country,
  (SELECT COUNT(*)
   FROM cities
   WHERE countries.code = cities.country_code) AS cities_num
FROM countries
ORDER BY cities_num DESC, country
LIMIT 9;

/*
The last type of subquery you will work with is one inside of FROM.
You will use this to determine the number of languages spoken for each country, identified by the country's local name! (Note this may be different than the name field and is stored in the local_name field.)
*/

/*
Instruction 1/2
Begin by determining for each country code how many languages are listed in the languages table using SELECT, FROM, and GROUP BY.
Alias the aggregated field as lang_num.
*/
SELECT code, COUNT(name) AS lang_num
FROM languages
GROUP BY code;

/*
Instruction 2/2
Include the previous query (aliased as subquery) as a subquery in the FROM clause of a new query.
Select the local name of the country from countries.
Also, select lang_num from subquery.
Make sure to use WHERE appropriately to match code in countries and in subquery.
Sort by lang_num in descending order.
*/
SELECT local_name, subquery.lang_num
FROM countries, 
    (SELECT code, COUNT(name) AS lang_num
    FROM languages
    GROUP BY code) as subquery
WHERE countries.code = subquery.code
ORDER BY lang_num DESC;

/*
You can also nest multiple subqueries to answer even more specific questions.
In this exercise, for each of the six continents listed in 2015, you'll identify which country had the maximum inflation rate (and how high it was) using multiple subqueries. The table result of your query in Task 3 should look something like the following, where anything between < > will be filled in with appropriate values:
+------------+---------------+-------------------+
| name       | continent     | inflation_rate    |
|------------+---------------+-------------------|
| <country1> | North America | <max_inflation1>  |
| <country2> | Africa        | <max_inflation2>  |
| <country3> | Oceania       | <max_inflation3>  |
| <country4> | Europe        | <max_inflation4>  |
| <country5> | South America | <max_inflation5>  |
| <country6> | Asia          | <max_inflation6>  |
+------------+---------------+-------------------+
Again, there are multiple ways to get to this solution using only joins, but the focus here is on showing you an introduction into advanced subqueries.
*/

/*
Instructions 1/3
Create an inner join with countries on the left and economies on the right with USING. Do not alias your tables or columns.
Retrieve the country name, continent, and inflation rate for 2015.
*/
SELECT name, continent, inflation_rate
FROM countries 
INNER JOIN economies
USING (code)
WHERE year = 2015;

/*
Instructions 2/3
Determine the maximum inflation rate for each continent in 2015 using the previous query as a subquery called subquery in the FROM clause.
Select the maximum inflation rate AS max_inf grouped by continent.
This will result in the six maximum inflation rates in 2015 for the six continents as one field table. (Don't include continent in the outer SELECT statement.)
*/
SELECT MAX(inflation_rate) AS max_inf
  FROM (
      SELECT name, continent, inflation_rate
      FROM countries
      INNER JOIN economies
      USING (code)
      WHERE year = 2015) AS subquery
GROUP BY continent;

/*
Instructions 3/3
Append the second part's query to the first part's query using WHERE, AND, and IN to obtain the name of the country, its continent, and the maximum inflation rate for each continent in 2015. Revisit the sample output in the assignment text at the beginning of the exercise to see how this matches up.
For the sake of practice, change all joining conditions to use ON instead of USING.
This code works since each of the six maximum inflation rate values occur only once in the 2015 data. Think about whether this particular code involving subqueries would work in cases where there are ties for the maximum inflation rate values.
*/
SELECT name, continent, inflation_rate
FROM countries
INNER JOIN economies
ON countries.code = economies.code
WHERE year = 2015
    AND inflation_rate IN (
        SELECT MAX(inflation_rate) AS max_inf
        FROM (
             SELECT name, continent, inflation_rate
             FROM countries
             INNER JOIN economies
             ON countries.code = economies.code
             WHERE year = 2015) AS subquery
        GROUP BY continent);

/*
Let's test your understanding of the subqueries with a challenge problem! Use a subquery to get 2015 economic data for countries that do not have
gov_form of 'Constitutional Monarchy' or
'Republic' in their gov_form.
Here, gov_form stands for the form of the government for each country. Review the different entries for gov_form in the countries table.
*/

/*
Select the country code, inflation rate, and unemployment rate.
Order by inflation rate ascending.
Do not use table aliasing in this exercise.
*/
SELECT code, inflation_rate, unemployment_rate
FROM economies
WHERE year = 2015 AND code NOT IN
  (SELECT code
   FROM countries
   WHERE (gov_form = 'Constitutional Monarchy' OR gov_form LIKE '%Republic'))
ORDER BY inflation_rate;

/*
Welcome to the end of the course! The next three exercises will test your knowledge of the content covered in this course and apply many of the ideas you've seen to difficult problems. Good luck!
Read carefully over the instructions and solve them step-by-step, thinking about how the different clauses work together.
In this exercise, you'll need to get the country names and other 2015 data in the economies table and the countries table for Central American countries with an official language.
*/

/*
Instructions
Select unique country names. Also select the total investment and imports fields.
Use a left join with countries on the left. (An inner join would also work, but please use a left join here.)
Match on code in the two tables AND use a subquery inside of ON to choose the appropriate languages records.
Order by country name ascending.
Use table aliasing but not field aliasing in this exercise.
*/
SELECT DISTINCT c.name, e.total_investment, e.imports
FROM countries AS c
LEFT JOIN economies AS e
ON (c.code = e.code AND c.code IN 
    (SELECT code 
    FROM languages
    WHERE official = 'true'))
WHERE year = 2015 AND region = 'Central America'
ORDER BY c.name;

/*
Whoofta! That was challenging, huh?
Let's ease up a bit and calculate the average fertility rate for each region in 2015.
*/

/*
Instructions
Include the name of region, its continent, and average fertility rate aliased as avg_fert_rate.
Sort based on avg_fert_rate ascending.
Remember that you'll need to GROUP BY all fields that aren't included in the aggregate function of SELECT.
*/
-- choose fields
SELECT region, continent, AVG(fertility_rate) AS avg_fert_rate
-- left table
FROM countries AS c
-- right table
INNER JOIN populations AS p
-- join conditions
ON c.code = p.country_code
-- specific records matching a condition
WHERE year = 2015
-- aggregated for each what?
GROUP BY region, continent
-- how should we sort?
ORDER BY avg_fert_rate;

/*
Welcome to the last challenge problem. By now you're a query warrior! Remember that these challenges are designed to take you to the limit to solidify your SQL knowledge! Take a deep breath and solve this step-by-step.
You are now tasked with determining the top 10 capital cities in Europe and the Americas in terms of a calculated percentage using city_proper_pop and metroarea_pop in cities.
After this exercise you are done with the course! If you enjoyed the material, feel free to send Chester a thank you via Twitter. .
Do not use table aliasing in this exercise.
*/

/*
Instructions
Select the city name, country code, city proper population, and metro area population.
Calculate the percentage of metro area population composed of city proper population for each city in cities, aliased as city_perc.
Focus only on capital cities in Europe and the Americas in a subquery.
Make sure to exclude records with missing data on metro area population.
Order the result by city_perc descending.
Then determine the top 10 capital cities in Europe and the Americas in terms of this city_perc percentage.
*/
SELECT name, country_code, city_proper_pop, metroarea_pop,  
      city_proper_pop / metroarea_pop * 100 AS city_perc
FROM cities
WHERE name IN
  (SELECT capital
   FROM countries
   WHERE (continent = 'Europe'
      OR continent LIKE '%America'))
     AND metroarea_pop IS NOT NULL
ORDER BY city_perc DESC
LIMIT 10;
