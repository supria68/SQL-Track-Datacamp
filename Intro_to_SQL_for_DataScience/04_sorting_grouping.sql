/*
Now that you understand how ORDER BY works, give these exercises a go!
*/

/*
Instructions
- Get the names of people from the people table, sorted alphabetically.
- Get the names of people, sorted by birth date.
- Get the birth date and name for every person, in order of when they were born.
*/

SELECT name FROM people ORDER BY name

SELECT name FROM people ORDER BY birthdate

SELECT birthdate, name FROM people ORDER BY birthdate

/*
Let's get some more practice with ORDER BY!
*/

/*
Instructions
- Get the title of films released in 2000 or 2012, in the order they were released.
- Get all details for all films except those released in 2015 and order them by duration.
- Get the title and gross earnings for movies which begin with the letter 'M' and order the results alphabetically.
*/

SELECT title FROM films WHERE release_year IN (2000,2012) ORDER BY release_year

SELECT * FROM films WHERE release_year NOT IN (2015) ORDER BY duration

SELECT title, gross FROM films WHERE title LIKE 'M%' ORDER BY title

/*
To order results in descending order, you can put the keyword DESC after your ORDER BY. For example, to get all the names in the people table, in reverse alphabetical order:
SELECT name
FROM people
ORDER BY name DESC;
Now practice using ORDER BY with DESC to sort single columns in descending order!
*/

/*
Instructions
- Get the IMDB score and film ID for every film from the reviews table, sorted from highest to lowest score.
- Get the title for every film, in reverse order.
- Get the title and duration for every film, in order of longest duration to shortest.
*/

SELECT imdb_score, film_id FROM reviews ORDER BY imdb_score DESC

SELECT title FROM films ORDER BY title DESC

SELECT title, duration FROM films ORDER BY duration DESC

/*
ORDER BY can also be used to sort on multiple columns. It will sort by the first column specified, then sort by the next, then the next, and so on. For example,
SELECT birthdate, name
FROM people
ORDER BY birthdate, name;
sorts on birth dates first (oldest to newest) and then sorts on the names in alphabetical order. The order of columns is important!
Try using ORDER BY to sort multiple columns! Remember, to specify multiple columns you separate the column names with a comma.
*/

/*
Instructions
- Get the birth date and name of people in the people table, in order of when they were born and alphabetically by name.
- Get the release year, duration, and title of films ordered by their release year and duration.
- Get certifications, release years, and titles of films ordered by certification (alphabetically) and release year.
- Get the names and birthdates of people ordered by name and birth date.
*/

SELECT birthdate, name FROM people ORDER BY birthdate, name

SELECT release_year, duration, title FROM films ORDER BY release_year, duration

SELECT certification, release_year, title FROM films ORDER BY certification, release_year

SELECT name, birthdate FROM people ORDER BY name, birthdate

/*
As you've just seen, combining aggregate functions with GROUP BY can yield some powerful results!
A word of warning: SQL will return an error if you try to SELECT a field that is not in your GROUP BY clause without using it to calculate some kind of value about the entire group.
Note that you can combine GROUP BY with ORDER BY to group your results, calculate something about them, and then order your results. For example,
SELECT sex, count(*)
FROM employees
GROUP BY sex
ORDER BY count DESC;
might return something like
sex	count
female	19
male	15
because there are more females at our company than males. Note also that ORDER BY always goes after GROUP BY. Let's try some exercises!
*/

/*
Instructions
- Get the release year and count of films released in each year.
- Get the release year and average duration of all films, grouped by release year.
- Get the release year and largest budget for all films, grouped by release year.
- Get the IMDB score and count of film reviews grouped by IMDB score in the reviews table.
*/

SELECT release_year, COUNT(*) FROM films GROUP BY (release_year)

SELECT release_year, AVG(duration) FROM films GROUP BY (release_year)

SELECT release_year, MAX(budget) FROM films GROUP BY (release_year)

SELECT imdb_score, COUNT(*) FROM reviews GROUP BY (imdb_score)

/*
Now practice your new skills by combining GROUP BY and ORDER BY with some more aggregate functions!
Make sure to always put the ORDER BY clause at the end of your query. You can't sort values that you haven't calculated yet!
*/

/*
Instructions
- Get the release year and lowest gross earnings per release year.
- Get the language and total gross amount films in each language made.
- Get the country and total budget spent making movies in each country.
- Get the release year, country, and highest budget spent making a film for each year, for each country. Sort your results by release year and country.
- Get the country, release year, and lowest amount grossed per release year per country. Order your results by country and release year.
*/

SELECT release_year, MIN(gross) FROM films GROUP BY (release_year)

SELECT language, SUM(gross) FROM films GROUP BY (language)

SELECT country, SUM(budget) FROM films GROUP BY (country)

SELECT MAX(budget), MAX(release_year) as release_year, MAX(country) as country FROM films GROUP BY release_year, country ORDER BY release_year, country

SELECT MIN(gross), MIN(release_year) as release_year, MIN(country) as country FROM films GROUP BY release_year, country ORDER BY country,release_year

/*
Time to practice using ORDER BY, GROUP BY and HAVING together.
Now you're going to write a query that returns the average budget and average gross earnings for films in each year after 1990, if the average budget is greater than $60 million.
This is going to be a big query, but you can handle it!
*/

/*
Instructions
- Get the release year, budget and gross earnings for each film in the films table.
- Modify your query so that only records with a release_year after 1990 are included.
- Remove the budget and gross columns, and group your results by release year.
- Modify your query to include the average budget and average gross earnings for the results you have so far. Alias the average budget as avg_budget; alias the average gross earnings as avg_gross.
- Modify your query so that only years with an average budget of greater than $60 million are included.
- Finally, modify your query to order the results from highest average gross earnings to lowest.
*/

SELECT release_year, budget, gross FROM films

SELECT release_year, budget, gross FROM films WHERE release_year > 1990

SELECT release_year FROM films WHERE release_year > 1990 GROUP BY release_year 

SELECT release_year, AVG(budget) as avg_budget, AVG(gross) as avg_gross FROM films 
WHERE release_year > 1990 GROUP BY release_year 

SELECT release_year, AVG(budget) as avg_budget, AVG(gross) as avg_gross FROM films 
WHERE release_year > 1990 GROUP BY release_year 
HAVING AVG(budget) > 60000000

SELECT release_year, AVG(budget) as avg_budget, AVG(gross) as avg_gross FROM films 
WHERE release_year > 1990 GROUP BY release_year 
HAVING AVG(budget) > 60000000
ORDER BY AVG(gross) DESC

/*
Great work! Now try another large query. This time, all in one go!
Remember, if you only want to return a certain number of results, you can use the LIMIT keyword to limit the number of rows returned
*/

/*
Instructions
Get the country, average budget, and average gross take of countries that have made more than 10 films. Order the result by country name, and limit the number of results displayed to 5. You should alias the averages as avg_budget and avg_gross respectively.
*/

-- select country, average budget, average gross
SELECT country, AVG(budget) as avg_budget, AVG(gross) as avg_gross

-- from the films table
FROM films

-- group by country 
GROUP BY country

-- where the country has more than 10 titles
HAVING COUNT(title) > 10

-- order by country
ORDER BY country

-- limit to only show 5 results
LIMIT 5
