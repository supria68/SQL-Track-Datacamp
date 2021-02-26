/*
Near query result to the right, you will see two new tables with names economies2010 and economies2015.
*/

/*
Instructions
Combine these two tables into one table containing all of the fields in economies2010. The economies table is also included for reference.
Sort this resulting single table by country code and then by year, both in ascending order.
*/

-- pick specified columns from 2010 table
SELECT *
-- 2010 table will be on top
FROM economies2010
-- which set theory clause?
UNION
-- pick specified columns from 2015 table
SELECT *
-- 2015 table on the bottom
FROM economies2015
-- order accordingly
ORDER BY code, year;

/*
UNION can also be used to determine all occurrences of a field across multiple tables. Try out this exercise with no starter code.
*/

/*
Instructions
Determine all (non-duplicated) country codes in either the cities or the currencies table. The result should be a table with only one field called country_code.
Sort by country_code in alphabetical order.
*/

SELECT country_code
FROM cities
UNION
SELECT code as country_code
FROM currencies
ORDER BY country_code

/*
As you saw, duplicates were removed from the previous two exercises by using UNION.
To include duplicates, you can use UNION ALL.
*/

/*
Instructions
Determine all combinations (include duplicates) of country code and year that exist in either the economies or the populations tables. Order by code then year.
The result of the query should only have two columns/fields. Think about how many records this query should result in.
You'll use code very similar to this in your next exercise after the video. Make note of this code after completing it.
*/

SELECT code, year
FROM economies
UNION ALL
SELECT country_code, year
FROM populations
ORDER BY code, year;

/*
Repeat the previous UNION ALL exercise, this time looking at the records in common for country code and year for the economies and populations tables.
*/

/*
Instructions
Again, order by code and then by year, both in ascending order.
Note the number of records here (given at the bottom of query result) compared to the similar UNION ALL query result (814 records).
*/

SELECT code, year
FROM economies
INTERSECT
SELECT country_code, year
FROM populations
ORDER BY code, year;

/*
As you think about major world cities and their corresponding country, you may ask which countries also have a city with the same name as their country name?
*/

/*
Instructions
Use INTERSECT to answer this question with countries and cities!
*/

SELECT name
FROM countries
INTERSECT
SELECT name
FROM cities;

/*
Get the names of cities in cities which are not noted as capital cities in countries as a single field result.
Note that there are some countries in the world that are not included in the countries table, which will result in some cities not being labeled as capital cities when in fact they are.
*/

/*
Instructions
Order the resulting field in ascending order.
Can you spot the city/cities that are actually capital cities which this query misses?
*/

SELECT city.name
FROM cities AS city
EXCEPT
SELECT country.capital
FROM countries AS country
ORDER BY name;

/*
Now you will complete the previous query in reverse!
Determine the names of capital cities that are not listed in the cities table.
*/

/*
Instructions
Order by capital in ascending order.
The cities table contains information about 236 of the world's most populous cities. The result of your query may surprise you in terms of the number of capital cities that DO NOT appear in this list!
*/

SELECT country.capital
FROM countries AS country
EXCEPT
SELECT city.name
FROM cities AS city
ORDER BY capital;

/*
You are now going to use the concept of a semi-join to identify languages spoken in the Middle East.
*/

/*
Instructions 1/3
Flash back to our Intro to SQL for Data Science course and begin by selecting all country codes in the Middle East as a single field result using SELECT, FROM, and WHERE.
*/

SELECT * FROM countries
WHERE region='Middle East'

/*
Instructions 2/3
Comment out the answer to the previous tab by surrounding it in / * and * /. You'll come back to it!
Below the commented code, select only unique languages by name appearing in the languages table.
Order the resulting single field table by name in ascending order.
*/

SELECT DISTINCT name FROM languages
ORDER BY name

/*
Instructions 3/3
Now combine the previous two queries into one query:
Add a WHERE IN statement to the SELECT DISTINCT query, and use the commented out query from the first instruction in there. That way, you can determine the unique languages spoken in the Middle East.
Carefully review this result and its code after completing it. It serves as a great example of subqueries, which are the focus of Chapter 4.
*/
SELECT DISTINCT name FROM languages
WHERE code IN
    (SELECT code FROM countries
    WHERE region='Middle East')
ORDER BY name

/*
Another powerful join in SQL is the anti-join. It is particularly useful in identifying which records are causing an incorrect number of records to appear in join queries.
You will also see another example of a subquery here, as you saw in the first exercise on semi-joins. Your goal is to identify the currencies used in Oceanian countries!
*/

/*
Instructions 1/3
Begin by determining the number of countries in countries that are listed in Oceania using SELECT, FROM, and WHERE.
*/

SELECT COUNT(*) FROM countries
WHERE continent = 'Oceania'

/*
Instructions 2/3
Complete an inner join with countries AS c1 on the left and currencies AS c2 on the right to get the different currencies used in the countries of Oceania.
Match ON the code field in the two tables.
Include the country code, country name, and basic_unit AS currency.
Observe query result and make note of how many different countries are listed here.
*/

SELECT c1.code, c1.name, c2.basic_unit AS currency
FROM countries AS c1
INNER JOIN currencies AS c2
USING (code)
WHERE continent = 'Oceania';

/*
Instructions 3/3
Note that not all countries in Oceania were listed in the resulting inner join with currencies. Use an anti-join to determine which countries were not included!
Use NOT IN and (SELECT code FROM currencies) as a subquery to get the country code and country name for the Oceanian countries that are not included in the currencies table.
*/
SELECT c1.code, c1.name
FROM countries AS c1
WHERE c1.continent = 'Oceania'
    AND code NOT IN
    (SELECT code 
    FROM currencies);

/*
Congratulations! You've now made your way to the challenge problem for this third chapter. Your task here will be to incorporate two of UNION/UNION ALL/INTERSECT/EXCEPT to solve a challenge involving three tables.
In addition, you will use a subquery as you have in the last two exercises! This will be great practice as you hop into subqueries more in Chapter 4!
*/

/*
Instructions
Identify the country codes that are included in either economies or currencies but not in populations.
Use that result to determine the names of cities in the countries that match the specification in the previous instruction.
*/

-- select the city name
SELECT name
-- alias the table where city name resides
FROM cities AS c1
-- choose only records matching the result of multiple set theory clauses
WHERE country_code IN
(
     -- select appropriate field from economies AS e
    SELECT e.code
    FROM economies AS e
    -- get all additional (unique) values of the field from currencies AS c2  
    UNION
    SELECT c2.code
    FROM currencies AS c2
    -- exclude those appearing in populations AS p
    EXCEPT
    SELECT p.country_code
    FROM populations AS p
);

