1. Use the `SELECT` statement to query all data in the map.

    <code class="execute T2" title="Run command">
    SELECT * FROM cities;
    </code>

    You should see the following:

    ```
    +------------+--------------------+--------------------+
    |       __key|countries           |cities              |
    +------------+--------------------+--------------------+
    |           2|United Kingdom      |Manchester          |
    |           6|Turkey              |Ankara              |
    |           1|United Kingdom      |London              |
    |           7|Brazil              |Sao Paulo           |
    |           8|Brazil              |Rio de Janeiro      |
    |           5|Turkey              |Istanbul            |
    |           4|United States       |Los Angeles         |
    |           3|United States       |New York            |
    +------------+--------------------+--------------------+
    ```

1. Query only the countries by filtering on the `countries` column.

    <code class="execute T2" title="Run command">
    SELECT countries FROM cities;
    </code>

    ```
    +--------------------+
    |countries           |
    +--------------------+
    |United Kingdom      |
    |Turkey              |
    |United Kingdom      |
    |Brazil              |
    |Brazil              |
    |Turkey              |
    |United States       |
    |United States       |
    +--------------------+
    ```

1. Query only the cities by filtering on the `cities` column.

    <code class="execute T2" title="Run command">
    SELECT cities FROM cities;
    </code>

    ```
    +--------------------+
    |cities              |
    +--------------------+
    |Manchester          |
    |Ankara              |
    |London              |
    |Sao Paulo           |
    |Rio de Janeiro      |
    |Istanbul            |
    |Los Angeles         |
    |New York            |
    +--------------------+
    ```

1. Change the output to display cities first in alphabetical order. The `AS` command renames the columns to the given aliases

    **Note:** This clause does not rename the column in the table.

    <code class="execute T2" title="Run command">
    SELECT cities AS City, countries AS Country
    FROM cities
    ORDER BY cities;
    </code>

    ```
    +--------------------+--------------------+
    |City                |Country             |
    +--------------------+--------------------+
    |Ankara              |Turkey              |
    |Istanbul            |Turkey              |
    |London              |United Kingdom      |
    |Los Angeles         |United States       |
    |Manchester          |United Kingdom      |
    |New York            |United States       |
    |Rio de Janeiro      |Brazil              |
    |Sao Paulo           |Brazil              |
    +--------------------+--------------------+
    ```

1. Use a filter to display only countries where the name of the city is at least 11 characters long.

    <code class="execute T2" title="Run command">
    SELECT countries FROM cities WHERE LENGTH(cities) >= 11;
    </code>

    ```
    +--------------------+
    |countries           |
    +--------------------+
    |Brazil              |
    |United States       |
    +--------------------+
    ```

1. Use another filter to display only cities beginning with the letter 'L' where the length is greater than 6.

    <code class="execute T2" title="Run command">
    SELECT cities AS City
    FROM cities
    WHERE cities LIKE 'L%' AND LENGTH(cities) > 6;
    </code>

    ```
    +--------------------+
    |City                |
    +--------------------+
    |Los Angeles         |
    +--------------------+
    ```

1. Configure the map connector to create a new map table called `population2020`.

    <code class="execute T2" title="Run command">
    CREATE MAPPING population2020 (
    __key INT,
    cities VARCHAR,
    population INT)
    TYPE IMap OPTIONS ('keyFormat'='int', 'valueFormat'='json-flat');
    </code>

1. Add the 2020 populations of the following cities.

    <code class="execute T2" title="Run command">
    INSERT INTO population2020 VALUES
    (1, 'London', 9304016),
    (2, 'Manchester', 2730076),
    (3, 'New York', 8622357),
    (4, 'Los Angeles', 4085014),
    (5, 'Sao Paulo', 12396372),
    (6, 'Rio de Janeiro', 6775561),
    (7, 'Istanbul', 14804116),
    (8, 'Ankara', 3517182);
    </code>

1. Use the `JOIN` clause to merge results from the `cities` and `population2020` tables so you can see which countries had the most populated captial cities in 2020.

    <code class="execute T2" title="Run command">
    SELECT cities.countries AS country, cities.cities AS city, population2020.population AS population
    FROM cities
    JOIN population2020
    ON cities.cities = population2020.cities;
    </code>

    ```
    +--------------------+--------------------+------------+
    |country             |city                |  population|
    +--------------------+--------------------+------------+
    |United Kingdom      |Manchester          |     2730076|
    |Turkey              |Ankara              |     3517182|
    |United Kingdom      |London              |     9304016|
    |Brazil              |Sao Paulo           |    12396372|
    |Brazil              |Rio de Janeiro      |     6775561|
    |Turkey              |Istanbul            |    14804116|
    |United States       |Los Angeles         |     4085014|
    |United States       |New York            |     8622357|
    +--------------------+--------------------+------------+
    ```

1. Use the `ORDER BY` clause to order the results based on population, largest first.

    <code class="execute T2" title="Run command">
    SELECT cities.countries AS country, cities.cities AS city, population2020.population AS population
    FROM cities
    JOIN population2020
    ON cities.cities = population2020.cities
    ORDER BY population2020.population DESC;
    </code>

    ```
    +--------------------+--------------------+------------+
    |country             |city                |  population|
    +--------------------+--------------------+------------+
    |Turkey              |Istanbul            |    14804116|
    |Brazil              |Sao Paulo           |    12396372|
    |United Kingdom      |London              |     9304016|
    |United States       |New York            |     8622357|
    |Brazil              |Rio de Janeiro      |     6775561|
    |United States       |Los Angeles         |     4085014|
    |Turkey              |Ankara              |     3517182|
    |United Kingdom      |Manchester          |     2730076|
    +--------------------+--------------------+------------+
    ```

1. Use the `SUM()` function to find the total population of all the cities in 2020.

    <code class="execute T2" title="Run command">
    SELECT SUM(population2020.population) AS total_population
    FROM population2020;
    </code>

    You should see the following:

    ```
    +--------------------+
    |    total_population|
    +--------------------+
    |            62234694|
    +--------------------+
    ```

1. Filter for cities that had a population of more than 5,000,000 in 2020.

    <code class="execute T2" title="Run command">
    SELECT population2020.cities AS large_cities
    FROM population2020
    WHERE population2020.population > 5000000;
    </code>

    ```
    +--------------------+
    |large_cities        |
    +--------------------+
    |New York            |
    |Rio de Janeiro      |
    |London              |
    |Istanbul            |
    |Sao Paulo           |
    +--------------------+
    ```

1. Display the names of countries and the sum of the city populations. Order by population in ascending order.

    <code class="execute T2" title="Run command">
    SELECT cities.countries AS country, SUM(population2020.population) AS total_population
    FROM cities
    JOIN population2020
    ON cities.cities = population2020.cities
    GROUP BY cities.countries
    ORDER by sum(population2020.population);
    </code>

    ```
    +--------------------+--------------------+
    |country             |    total_population|
    +--------------------+--------------------+
    |United Kingdom      |            12034092|
    |United States       |            12707371|
    |Turkey              |            18321298|
    |Brazil              |            19171933|
    +--------------------+--------------------+
    ```

1. Display the names of countries and the sum of the city populations where the sum is > 15000000.

    <code class="execute T2" title="Run command">
    SELECT cities.countries AS country, sum(population2020.population) AS total_population
    FROM cities
    JOIN population2020
    ON cities.cities = population2020.cities
    GROUP BY cities.countries HAVING SUM(population2020.population) > 15000000;
    </code>

    ```
    +--------------------+--------------------+
    |country             |    total_population|
    +--------------------+--------------------+
    |Turkey              |            18321298|
    |Brazil              |            19171933|
    +--------------------+--------------------+
    ```
    
    The `HAVING` clause allows you to filter aggregations like you would with the `WHERE` clause for non-aggregated queries.

