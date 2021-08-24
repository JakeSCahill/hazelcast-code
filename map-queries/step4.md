1. Use the `SELECT` statement to query all data in the map.
    <code class="execute T2" title="Run command">
    SELECT * FROM cities;
    </code>

    You should see the following:

    ```
    +--------------------+--------------------+
    |__key               |this                |
    +--------------------+--------------------+
    |England             |London              |
    |United States       |Washington, DC      |
    |Czech Republic      |Prague              |
    |Turkey              |Ankara              |
    |Croatia             |Zagreb              |
    |Australia           |Canberra            |
    +--------------------+--------------------+
    ```

1. Query only the countries by filtering on the `__key` column.

    <code class="execute T2" title="Run command">
    SELECT __key FROM cities;
    </code>

    ```
    +--------------------+
    |__key               |
    +--------------------+
    |England             |
    |United States       |
    |Czech Republic      |
    |Turkey              |
    |Croatia             |
    |Australia           |
    +--------------------+
    ```

1. Query only the cities by filtering on the `this` column.

    <code class="execute T2" title="Run command">
    SELECT this FROM cities;
    </code>

    ```
    +--------------------+
    |this                |
    +--------------------+
    |London              |
    |Washington, DC      |
    |Prague              |
    |Ankara              |
    |Zagreb              |
    |Canberra            |
    +--------------------+
    ```

1. Give your query results more context by adding an alias to the `__key` and `this` columns.

    **Note:** This clause does not rename the column in the table.

    <code class="execute T2" title="Run command">
    SELECT __key AS countries, this AS cities
    FROM cities;
    </code>
    
    ```
    +--------------------+--------------------+
    |countries           |cities              |
    +--------------------+--------------------+
    |England             |London              |
    |United States       |Washington, DC      |
    |Czech Republic      |Prague              |
    |Turkey              |Ankara              |
    |Croatia             |Zagreb              |
    |Australia           |Canberra            |
    +--------------------+--------------------+
    ```

1. Use a filter to display only countries where the name of the capital city is at least 8 characters long.

    <code class="execute T2" title="Run command">
    SELECT __key AS countries FROM cities WHERE LENGTH(this) >= 8;
    </code>

    ```
    +--------------------+
    |countries           |
    +--------------------+
    |United States       |
    |Australia           |
    +--------------------+
    ```

1. Use another filter to display only countries beginning with the letter C where the name of the capital city is at least 6 characters long.

    ```sql
    SELECT __key AS countries
    FROM cities
    WHERE LENGTH(this) >= 6 AND __key LIKE 'C%';
    ```

    ```
    +--------------------+
    |countries           |
    +--------------------+
    |Czech Republic      |
    |Croatia             |
    +--------------------+
    ```

1. Configure the map connector to create a new map table called `population2020`.

    <code class="execute T2" title="Run command">
    CREATE MAPPING population2020
    TYPE IMap OPTIONS ('keyFormat'='varchar', 'valueFormat'='int');
    </code>

1. Add the 2020 populations of the following cities.

    <code class="execute T2" title="Run command">
    INSERT INTO population2020 VALUES ('Canberra', 354644);
    </code>

    <code class="execute T2" title="Run command">
    INSERT INTO population2020 VALUES ('Zagreb', 804200);
    </code>

    <code class="execute T2" title="Run command">
    INSERT INTO population2020 VALUES ('Prague', 1227332);
    </code>

    <code class="execute T2" title="Run command">
    INSERT INTO population2020 VALUES ('London', 8174100);
    </code>

    <code class="execute T2" title="Run command">
    INSERT INTO population2020 VALUES ('Ankara', 4890893);
    </code>

    <code class="execute T2" title="Run command">
    INSERT INTO population2020 VALUES ('Washington, DC', 601723);
    </code>

1. Use the `JOIN` clause to merge results from the `cities` and `population2020` tables so you can see which countries had the most populated captial cities in 2020.

    ```sql
    SELECT cities.__key AS country, cities.this AS city, population2020.this AS population
    FROM cities
    JOIN population2020
    ON cities.this = population2020.__key;
    ```

    ```
    +--------------------+--------------------+------------+
    |country             |city                |  population|
    +--------------------+--------------------+------------+
    |England             |London              |     8174100|
    |United States       |Washington, DC      |      601723|
    |Czech Republic      |Prague              |     1227332|
    |Croatia             |Zagreb              |      804200|
    |Australia           |Canberra            |      354644|
    +--------------------+--------------------+------------+
    ```

1. Use the `ORDER BY` clause to order the results alphabetically by country.

    ```sql
    SELECT cities.__key AS country, cities.this AS city, population2020.this AS population
    FROM cities
    JOIN population2020
    ON cities.this = population2020.__key
    ORDER BY cities.__key;
    ```

    ```
    +--------------------+--------------------+------------+
    |country             |city                |  population|
    +--------------------+--------------------+------------+
    |Australia           |Canberra            |      354644|
    |Croatia             |Zagreb              |      804200|
    |Czech Republic      |Prague              |     1227332|
    |England             |London              |     8174100|
    |United States       |Washington, DC      |      601723|
    +--------------------+--------------------+------------+
    ```
