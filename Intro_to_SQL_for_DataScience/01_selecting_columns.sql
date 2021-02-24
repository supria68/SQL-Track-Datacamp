/*
While SQL can be used to create and modify databases, the focus of this course will be querying databases. A query is a request for data from a database table (or combination of tables). Querying is an essential skill for a data scientist, since the data you need for your analyses will often live in databases.
In SQL, you can select data from a table using a SELECT statement. For example, the following query selects the name column from the people table:
SELECT name
FROM people;
In this query, SELECT and FROM are called keywords. In SQL, keywords are not case-sensitive, which means you can write the same query as:
select name
from people;
That said, it's good practice to make SQL keywords uppercase to distinguish them from other parts of your query, like column and table names.
It's also good practice (but not necessary for the exercises in this course) to include a semicolon at the end of your query. This tells SQL where the end of your query is!
Remember, you can see the results of executing your query in the query result tab to the right!
*/

/*
Instructions
- Select the title column from the films table.
- Select the release_year column from the films table.
- Select the name of each person in the people table.
*/

SELECT title FROM films
SELECT release_year FROM films
SELECT name FROM people

/*
Well done! Now you know how to select single columns.
In the real world, you will often want to select multiple columns. Luckily, SQL makes this really easy. To select multiple columns from a table, simply separate the column names with commas!
For example, this query selects two columns, name and birthdate, from the people table:
SELECT name, birthdate
FROM people;
Sometimes, you may want to select all columns from a table. Typing out every column name would be a pain, so there's a handy shortcut:
SELECT *
FROM people;
If you only want to return a certain number of results, you can use the LIMIT keyword to limit the number of rows returned:
SELECT *
FROM people
LIMIT 10;
Before getting started with the instructions below, check out the column names in the films table by clicking on the films tab to the right!
*/

/*
Instructions 
- Get the title of every film from the films table.
- Get the title and release year for every film.
- Get the title, release year and country for every film.
- Get all columns from the films table.
*/

SELECT title FROM films

SELECT title, release_year 
FROM films;

SELECT title, release_year, country 
FROM films;

SELECT *
FROM films;

/*
Often your results will include many duplicate values. If you want to select all the unique values from a column, you can use the DISTINCT keyword.
This might be useful if, for example, you're interested in knowing which languages are represented in the films table:
SELECT DISTINCT language
FROM films;
Remember, you can check out the data in the tables by clicking on the tabs to the right under the editor!
*/

/*
Instructions
- Get all the unique countries represented in the films table.
- Get all the different film certifications from the films table.
- Get the different types of film roles from the roles table.
*/

SELECT DISTINCT country FROM films

SELECT DISTINCT certification FROM films

SELECT DISTINCT role FROM roles

/*
Learning to COUNT
What if you want to count the number of employees in your employees table? The COUNT statement lets you do this by returning the number of rows in one or more columns.
For example, this code gives the number of rows in the people table:
SELECT COUNT(*)
FROM people;
How many records are contained in the reviews table?
*/

4,968

/*
Practice with COUNT
As you've seen, COUNT(*) tells you how many rows are in a table. However, if you want to count the number of non-missing values in a particular column, you can call COUNT on just that column.
For example, to count the number of birth dates present in the people table:
SELECT COUNT(birthdate)
FROM people;
It's also common to combine COUNT with DISTINCT to count the number of distinct values in a column.
For example, this query counts the number of distinct birth dates contained in the people table:
SELECT COUNT(DISTINCT birthdate)
FROM people;
Let's get some practice with COUNT!
*/

/*
Instructions
- Count the number of rows in the people table.
- Count the number of (non-missing) birth dates in the people table.
- Count the number of unique birth dates in the people table.
- Count the number of unique languages in the films table.
- Count the number of unique countries in the films table.
*/

SELECT COUNT(*) FROM people

SELECT COUNT(birthdate)
FROM people;

SELECT COUNT(DISTINCT birthdate)
FROM people;

SELECT COUNT(DISTINCT language)
FROM films;

SELECT COUNT(DISTINCT country)
FROM films;

