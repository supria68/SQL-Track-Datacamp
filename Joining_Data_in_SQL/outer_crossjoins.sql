/*
Now you'll explore the differences between performing an inner join and a left join using the cities and countries tables.
You'll begin by performing an inner join with the cities table on the left and the countries table on the right. Remember to alias the name of the city field as city and the name of the country field as country.
You will then change the query to a left join. Take note of how many records are in each query here!
*/

/*
Instructions
- Fill in the code shown to complete the inner join. Note how many records are in the result of the join in the query result tab.
- Change the code to perform a LEFT JOIN instead of an INNER JOIN. After executing this query, note how many records the query result contains.
*/

-- get the city name (and alias it), the country code,
-- the country name (and alias it), the region,
-- and the city proper population
SELECT c1.name AS city, code, c2.name AS country,
       region, city_proper_pop
-- specify left table
FROM cities AS c1
-- specify right table and type of join
INNER JOIN countries AS c2
-- how should the tables be matched?
ON c1.country_code = c2.code
-- sort based on descending country code
ORDER BY code DESC;

-- get the city name (and alias it), the country code,
-- the country name (and alias it), the region,
-- and the city proper population
SELECT c1.name AS city, code, c2.name AS country,
       region, city_proper_pop
-- specify left table
FROM cities AS c1
-- specify right table and type of join
LEFT JOIN countries AS c2
-- how should the tables be matched?
ON c1.country_code = c2.code
-- sort based on descending country code
ORDER BY code DESC;

/*
Next, you'll try out another example comparing an inner join to its corresponding left join. Before you begin though, take note of how many records are in both the countries and languages tables below.
You will begin with an inner join on the countries table on the left with the languages table on the right. Then you'll change the code to a left join in the next bullet.
Note the use of multi-line comments here using /* and */.
*/

/*
Instructions
- Perform an inner join. Alias the name of the country field as country and the name of the language field as language. Sort based on descending country name.
- Perform a left join instead of an inner join. Observe the result, and also note the change in the number of records in the result. Carefully review which records appear in the left join result, but not in the inner join result.
*/

/*
select country name AS country, the country's local name,
the language name AS language, and
the percent of the language spoken in the country
*/
SELECT c.name AS country, local_name, l.name AS language, percent
-- countries on the left (alias as c)
FROM countries AS c
-- appropriate join with languages (as l) on the right
INNER JOIN languages AS l
-- give fields to match on
ON c.code = l.code
-- sort by descending country name
ORDER BY country DESC;

/*
select country name AS country, the country's local name,
the language name AS language, and
the percent of the language spoken in the country
*/
SELECT c.name AS country, local_name, l.name AS language, percent
-- countries on the left (alias as c)
FROM countries AS c
-- appropriate join with languages (as l) on the right
LEFT JOIN languages AS l
-- give fields to match on
ON c.code = l.code
-- sort by descending country name
ORDER BY country DESC;

/*
You'll now revisit the use of the AVG() function introduced in our Intro to SQL for Data Science course. You will use it in combination with left join to determine the average gross domestic product (GDP) per capita by region in 2010.
*/

/*
Instructions 1/3
Begin with a left join with the countries table on the left and the economies table on the right.
Focus only on records with 2010 as the year.
*/
-- select name, region, and gdp_percapita
SELECT name, region, gdp_percapita
-- from countries (alias c) on the left
FROM countries AS c
-- left join with economies (alias e)
LEFT JOIN economies AS e
-- match on code fields
ON c.code = e.code
-- focus on 2010 entries
WHERE e.year = 2010;

/*
Instructions 2/3
Modify your code to calculate the average GDP per capita AS avg_gdp for each region in 2010. Select the region and avg_gdp fields.
*/
-- Select region, average gdp_percapita (alias avg_gdp)
SELECT region, AVG(gdp_percapita) as avg_gdp
-- From countries (alias c) on the left
FROM countries AS c
-- Join with economies (alias e)
LEFT JOIN economies AS e
-- Match on code fields
ON c.code = e.code
-- Focus on 2010 
WHERE year = 2010
-- Group by region
GROUP BY region;

/*
Instructions 3/3
Arrange this data on average GDP per capita for each region in 2010 from highest to lowest average GDP per capita.
*/
-- Select region, average gdp_percapita (alias avg_gdp)
SELECT region, AVG(gdp_percapita) as avg_gdp
-- From countries (alias c) on the left
FROM countries AS c
-- Join with economies (alias e)
LEFT JOIN economies AS e
-- Match on code fields
ON c.code = e.code
-- Focus on 2010 
WHERE year = 2010
-- Group by region
GROUP BY region
-- Order by avg_gdp, descending
ORDER BY avg_gdp DESC;

/*
Right joins aren't as common as left joins. One reason why is that you can always write a right join as a left join.
*/

/*
Instructions
The left join code is commented out here. Your task is to write a new query using rights joins that produces the same result as what the query using left joins produces. Keep this left joins code commented as you write your own query just below it using right joins to solve the problem.
Note the order of the joins matters in your conversion to using right joins!
*/

SELECT cities.name AS city, urbanarea_pop, countries.name AS country,
       indep_year, languages.name AS language, percent
FROM languages
RIGHT JOIN countries
ON countries.code = languages.code
RIGHT JOIN cities
ON cities.country_code = countries.code
ORDER BY city, language;

/*
In this exercise, you'll examine how your results differ when using a full join versus using a left join versus using an inner join with the countries and currencies tables.
You will focus on the North American region and also where the name of the country is missing. Dig in to see what we mean!
Begin with a full join with countries on the left and currencies on the right. The fields of interest have been SELECTed for you throughout this exercise.
Then complete a similar left join and conclude with an inner join.
*/

/*
Instructions
- Choose records in which region corresponds to North America or is NULL.
- Repeat the same query as above but use a LEFT JOIN instead of a FULL JOIN. Note what has changed compared to the FULL JOIN result!
- Repeat the same query as above but use an INNER JOIN instead of a FULL JOIN. Note what has changed compared to the FULL JOIN and LEFT JOIN results!
*/

SELECT name AS country, code, region, basic_unit
FROM countries
FULL JOIN currencies
USING (code)
WHERE region = 'North America' OR region IS NULL
ORDER BY region;

SELECT name AS country, code, region, basic_unit
FROM countries
LEFT JOIN currencies
USING (code)
WHERE region = 'North America' OR region IS NULL
ORDER BY region;

SELECT name AS country, code, region, basic_unit
FROM countries
INNER JOIN currencies
USING (code)
WHERE region = 'North America' OR region IS NULL
ORDER BY region;

/*
You'll now investigate a similar exercise to the last one, but this time focused on using a table with more records on the left than the right. You'll work with the languages and countries tables.
Begin with a full join with languages on the left and countries on the right. Appropriate fields have been selected for you again here.
*/

/*
Instructions 1/3
Choose records in which countries.name starts with the capital letter 'V' or is NULL.
Arrange by countries.name in ascending order to more clearly see the results.
*/
SELECT countries.name, code, languages.name AS language
FROM countries
FULL JOIN languages
USING (code)
WHERE countries.name LIKE 'V%' OR countries.name IS NULL
ORDER BY countries.name;

/*
Instructions 2/3
Repeat the same query as above but use a left join instead of a full join. Note what has changed compared to the full join result!
*/
SELECT countries.name, code, languages.name AS language
FROM languages
LEFT JOIN countries
USING (code)
WHERE countries.name LIKE 'V%' OR countries.name IS NULL
ORDER BY countries.name;

/*
Instructions 3/3
Repeat once more, but use an inner join instead of a left join. Note what has changed compared to the full join and left join results.
*/
SELECT countries.name, code, languages.name AS language
FROM languages
INNER JOIN countries
USING (code)
WHERE countries.name LIKE 'V%' OR countries.name IS NULL
ORDER BY countries.name;


/*
You'll now explore using two consecutive full joins on the three tables you worked with in the previous two exercises.
*/

/*
Instructions
Complete a full join with countries on the left and languages on the right.
Next, full join this result with currencies on the right.
Select the fields corresponding to the country name AS country, region, language name AS language, and basic and fractional units of currency.
Use LIKE to choose the Melanesia and Micronesia regions (Hint: 'M%esia').
*/

SELECT c1.name AS country, region, l.name AS language,
       basic_unit, frac_unit
FROM countries AS c1
FULL JOIN languages AS l
USING (code)
FULL JOIN currencies AS c2
USING (code)
WHERE region LIKE 'M%esia';

/*
This exercise looks to explore languages potentially and most frequently spoken in the cities of Hyderabad, India and Hyderabad, Pakistan.
You will begin with a cross join with cities AS c on the left and languages AS l on the right. Then you will modify the query using an inner join in the next tab.
*/

/*
Instructions 1/2
Create the cross join above and select only the city name AS city and language name AS language. (Recall that cross joins do not use ON or USING.)
Make use of LIKE and Hyder% to choose Hyderabad in both countries.
*/
SELECT c.name AS city, l.name AS language
FROM cities AS c        
CROSS JOIN languages AS l
-- ON ___
WHERE c.name LIKE 'Hyder%';

/*
Instructions 2/2
Use an inner join instead of a cross join. Think about what the difference will be in the results for this inner join result and the one for the cross join.
*/
SELECT c.name AS city, l.name AS language
FROM cities AS c        
INNER JOIN languages AS l
ON c.country_code = l.code
WHERE c.name LIKE 'Hyder%';

/*
Now that you're fully equipped to use outer joins, try a challenge problem to test your knowledge!
In terms of life expectancy for 2010, determine the names of the lowest five countries and their regions.
*/

/*
Instructions
Select country name AS country, region, and life expectancy AS life_exp.
Make sure to use LEFT JOIN, WHERE, ORDER BY, and LIMIT.
*/
SELECT c.name as country, region, p.life_expectancy as life_exp
FROM countries as c
LEFT JOIN populations as p
ON c.code = p.country_code
WHERE p.year = 2010
ORDER BY life_exp
LIMIT 5;
