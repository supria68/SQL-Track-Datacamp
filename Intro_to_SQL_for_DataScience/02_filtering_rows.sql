/*
As you learned in the previous exercise, the WHERE clause can also be used to filter numeric records, such as years or ages.
For example, the following query selects all details for films with a budget over ten thousand dollars:
SELECT *
FROM films
WHERE budget > 10000;
Now it's your turn to use the WHERE clause to filter numeric values!
*/

/*
Instructions
- Get all details for all films released in 2016.
- Get the number of films released before 2000.
- Get the title and release year of films released after 2000.
*/

SELECT * FROM films WHERE release_year = 2016

SELECT COUNT(*) FROM films WHERE release_year < 2000

SELECT title, release_year FROM films WHERE release_year > 2000

/*
Remember, the WHERE clause can also be used to filter text results, such as names or countries.
For example, this query gets the titles of all films which were filmed in China:
SELECT title
FROM films
WHERE country = 'China';
Now it's your turn to practice using WHERE with text values!
Important: in PostgreSQL (the version of SQL we're using), you must use single quotes with WHERE.
*/

/*
Instructions
- Get all details for all French language films.
- Get the name and birth date of the person born on November 11th, 1974. Remember to use ISO date format ('1974-11-11')!
- Get the number of Hindi language films.
- Get all details for all films with an R certification.
*/

SELECT * FROM films WHERE language='French'

SELECT name, birthdate FROM people WHERE birthdate='1974-11-11'

SELECT COUNT(*) FROM films WHERE language='Hindi'

SELECT * FROM films WHERE certification='R'

/*
Often, you'll want to select data based on multiple conditions. You can build up your WHERE queries by combining multiple conditions with the AND keyword.
For example,
SELECT title
FROM films
WHERE release_year > 1994
AND release_year < 2000;
gives you the titles of films released between 1994 and 2000.
Note that you need to specify the column name separately for every AND condition, so the following would be invalid:
SELECT title
FROM films
WHERE release_year > 1994 AND < 2000;
You can add as many AND conditions as you need!
*/

/*
Instructions
- Get the title and release year for all Spanish language films released before 2000.
- Get all details for Spanish language films released after 2000.
- Get all details for Spanish language films released after 2000, but before 2010.
*/

SELECT title, release_year FROM films WHERE language='Spanish' AND release_year < 2000

SELECT * FROM films WHERE language='Spanish' AND release_year > 2000

SELECT * FROM films WHERE language='Spanish' AND release_year > 2000 AND release_year <2010

/*
You now know how to select rows that meet some but not all conditions by combining AND and OR.
For example, the following query selects all films that were released in 1994 or 1995 which had a rating of PG or R.
SELECT title
FROM films
WHERE (release_year = 1994 OR release_year = 1995)
AND (certification = 'PG' OR certification = 'R');
Now you'll write a query to get the title and release year of films released in the 90s which were in French or Spanish and which took in more than $2M gross.
It looks like a lot, but you can build the query up one step at a time to get comfortable with the underlying concept in each step. Let's go!
*/

/*
Instructions
- Get the title and release year for films released in the 90s.
- Now, build on your query to filter the records to only include French or Spanish language films.
- Finally, restrict the query to only return films that took in more than $2M gross.
*/

SELECT title, release_year FROM films WHERE release_year>1989 AND release_year<2000

SELECT title, release_year FROM films WHERE (release_year>=1990 AND release_year<2000) AND (language = 'French' OR language = 'Spanish')

SELECT title, release_year FROM films WHERE (release_year>=1990 AND release_year<2000) AND (language = 'French' OR language = 'Spanish') AND (gross>2000000)

/*
Similar to the WHERE clause, the BETWEEN clause can be used with multiple AND and OR operators, so you can build up your queries and make them even more powerful!
For example, suppose we have a table called kids. We can get the names of all kids between the ages of 2 and 12 from the United States:
SELECT name
FROM kids
WHERE age BETWEEN 2 AND 12
AND nationality = 'USA';
Take a go at using BETWEEN with AND on the films data to get the title and release year of all Spanish language films released between 1990 and 2000 (inclusive) with budgets over $100 million. We have broken the problem into smaller steps so that you can build the query as you go along!
*/

/*
Instructions
- Get the title and release year of all films released between 1990 and 2000 (inclusive).
- Now, build on your previous query to select only films that have budgets over $100 million.
- Now restrict the query to only return Spanish language films.
- Finally, modify to your previous query to include all Spanish language or French language films with the same criteria as before. Don't forget your parentheses!
*/

SELECT title, release_year FROM films WHERE release_year BETWEEN 1990 AND 2000

SELECT title, release_year FROM films WHERE release_year BETWEEN 1990 AND 2000
AND budget > 100000000

SELECT title, release_year FROM films WHERE release_year BETWEEN 1990 AND 2000
AND budget > 100000000 AND language='Spanish'

SELECT title, release_year FROM films WHERE release_year BETWEEN 1990 AND 2000
AND budget > 100000000 AND (language='Spanish' OR language='French')

/*
As you've seen, WHERE is very useful for filtering results. However, if you want to filter based on many conditions, WHERE can get unwieldy. For example:
SELECT name
FROM kids
WHERE age = 2
OR age = 4
OR age = 6
OR age = 8
OR age = 10;
Enter the IN operator! The IN operator allows you to specify multiple values in a WHERE clause, making it easier and quicker to specify multiple OR conditions! Neat, right?
So, the above example would become simply:
SELECT name
FROM kids
WHERE age IN (2, 4, 6, 8, 10);
Try using the IN operator yourself!
*/

/*
Instructions
- Get the title and release year of all films released in 1990 or 2000 that were longer than two hours. Remember, duration is in minutes!
- Get the title and language of all films which were in English, Spanish, or French.
- Get the title and certification of all films with an NC-17 or R certification.
*/

SELECT title, release_year FROM films WHERE (release_year=1990 OR release_year=2000) AND 
duration > 120

SELECT title, language FROM films WHERE 
language IN ('English', 'Spanish', 'French')

SELECT title, certification FROM films WHERE 
certification IN ('NC-17', 'R')

/*
Now that you know what NULL is and what it's used for, it's time for some practice!
*/

/*
Instructions
- Get the names of people who are still alive, i.e. whose death date is missing.
- Get the title of every film which doesn't have a budget associated with it.
- Get the number of films which don't have a language associated with them.
*/

SELECT name FROM people WHERE deathdate IS NULL

SELECT title FROM films WHERE budget IS NULL

SELECT COUNT(*) FROM films WHERE language IS NULL

/*
As you've seen, the WHERE clause can be used to filter text data. However, so far you've only been able to filter by specifying the exact text you're interested in. In the real world, often you'll want to search for a pattern rather than a specific text string.
In SQL, the LIKE operator can be used in a WHERE clause to search for a pattern in a column. To accomplish this, you use something called a wildcard as a placeholder for some other values. There are two wildcards you can use with LIKE:
The % wildcard will match zero, one, or many characters in text. For example, the following query matches companies like 'Data', 'DataC' 'DataCamp', 'DataMind', and so on:
SELECT name
FROM companies
WHERE name LIKE 'Data%';
The _ wildcard will match a single character. For example, the following query matches companies like 'DataCamp', 'DataComp', and so on:
SELECT name
FROM companies
WHERE name LIKE 'DataC_mp';
You can also use the NOT LIKE operator to find records that don't match the pattern you specify.
Got it? Let's practice!
*/

/*
Instructions
- Get the names of all people whose names begin with 'B'. The pattern you need is 'B%'
- Get the names of people whose names have 'r' as the second letter. The pattern you need is '_r%'.
- Get the names of people whose names don't start with A. The pattern you need is 'A%'
*/

SELECT name FROM people WHERE name LIKE 'B%'

SELECT name FROM people WHERE name LIKE '_r%'

SELECT name FROM people WHERE name NOT LIKE 'A%'
