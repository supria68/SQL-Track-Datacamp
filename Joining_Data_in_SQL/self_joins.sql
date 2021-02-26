
/*
In this exercise, you'll use the populations table to perform a self-join to calculate the percentage increase in population from 2010 to 2015 for each country code!
Since you'll be joining the populations table to itself, you can alias populations as p1 and also populations as p2. This is good practice whenever you are aliasing and your tables have the same first letter. Note that you are required to alias the tables with self-joins.
*/

/*
Instructions 1/3
Join populations with itself ON country_code.
Select the country_code from p1.
Select the size field from both p1 and p2. SQL won't allow same-named fields, so alias p1.size as size2010 and p2.size as size2015.
*/
SELECT p1.country_code, 
       p1.size AS size2010,
       p2.size AS size2015
FROM populations AS p1
INNER JOIN populations AS p2
ON  p1.country_code = p2.country_code;

/*
Instructions 2/3
Notice from the result that for each country_code you have four entries laying out all combinations of 2010 and 2015.
Extend the ON in your query to include only those records where the p1.year (2010) matches with p2.year - 5 (2015 - 5 = 2010).
This will omit the three entries per country_code that you aren't interested in.
*/
SELECT p1.country_code, 
       p1.size AS size2010,
       p2.size AS size2015
FROM populations AS p1
INNER JOIN populations AS p2
ON p1.country_code = p2.country_code
    AND p1.year = p2.year - 5;

/*
Instructions 3/3
As you just saw, you can also use SQL to calculate values like p2.year - 5 for you. With two fields like size2010 and size2015, you may want to determine the percentage increase from one field to the next:
With two numeric fields A and B, the percentage growth from A to B can be calculated as (B−A)/A∗100.0.
To SELECT add a new field aliased as growth_perc that calculates the percentage population growth from 2010 to 2015 for each country, using p2.size and p1.size.
*/
SELECT p1.country_code, 
       p1.size AS size2010,
       p2.size AS size2015,
       ((p2.size - p1.size)/p1.size * 100.0) AS growth_perc
FROM populations AS p1
INNER JOIN populations AS p2
ON p1.country_code = p2.country_code
    AND p1.year = p2.year - 5;

/*
Often it's useful to look at a numerical field not as raw data, but instead as being in different categories or groups.
You can use CASE with WHEN, THEN, ELSE, and END to define a new grouping field.
*/

/*
Instructions
Using the countries table, create a new field AS geosize_group that groups the countries into three groups:
If surface_area is greater than 2 million, geosize_group is 'large'.
If surface_area is greater than 350 thousand but not larger than 2 million, geosize_group is 'medium'.
Otherwise, geosize_group is 'small'
*/

SELECT name, continent, code, surface_area,
    CASE 
        -- first case
        WHEN surface_area > 2000000 THEN 'large'
        -- second case
        WHEN surface_area > 350000 THEN 'medium'
        -- else clause + end
        ELSE 'small' 
    END AS geosize_group
FROM countries;

/*
The table you created with the added geosize_group field has been loaded for you here with the name countries_plus. Observe the use of (and the placement of) the INTO command to create this countries_plus table:
SELECT name, continent, code, surface_area,
    CASE WHEN surface_area > 2000000
            THEN 'large'
       WHEN surface_area > 350000
            THEN 'medium'
       ELSE 'small' END
       AS geosize_group
INTO countries_plus
FROM countries;
You will now explore the relationship between the size of a country in terms of surface area and in terms of population using grouping fields created with CASE.
By the end of this exercise, you'll be writing two queries back-to-back in a single script. You got this!
*/

/*
Instructions 1/3
Using the populations table focused only for the year 2015, create a new field AS popsize_group to organize population size into
'large' (> 50 million),
'medium' (> 1 million), and
'small' groups.
Select only the country code, population size, and this new popsize_group as fields.
*/
SELECT country_code, size,
    CASE WHEN size > 50000000 THEN 'large'
        WHEN size > 1000000 THEN 'medium'
        ELSE 'small' END
        AS popsize_group
FROM populations
WHERE year = 2015;

/*
Instructions 2/3
Use INTO to save the result of the previous query as pop_plus. You can see an example of this in the countries_plus code in the assignment text. Make sure to include a ; at the end of your WHERE clause!
Then, include another query below your first query to display all the records in pop_plus using SELECT * FROM pop_plus; so that you generate results and this will display pop_plus in query result.
*/
SELECT country_code, size,
    CASE WHEN size > 50000000 THEN 'large'
        WHEN size > 1000000 THEN 'medium'
        ELSE 'small' END
        AS popsize_group
INTO pop_plus
FROM populations
WHERE year = 2015;

SELECT * FROM pop_plus;

/*
Instructions 3/3
Keep the first query intact that creates pop_plus using INTO.
Remove the SELECT * FROM pop_plus; code and instead write a second query to join countries_plus AS c on the left with pop_plus AS p on the right matching on the country code fields.
Select the name, continent, geosize_group, and popsize_group fields.
Sort the data based on geosize_group, in ascending order so that large appears on top.
*/
SELECT country_code, size,
    CASE WHEN size > 50000000 THEN 'large'
        WHEN size > 1000000 THEN 'medium'
        ELSE 'small' END
        AS popsize_group
INTO pop_plus
FROM populations
WHERE year = 2015;

SELECT c.name, c.continent, c.geosize_group, p.popsize_group
FROM countries_plus as c
INNER JOIN pop_plus as p
ON c.code = p.country_code
ORDER BY c.geosize_group;

