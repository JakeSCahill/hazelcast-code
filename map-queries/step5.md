1. Find the total population of all the cities in 2020.

    <code class="execute T2" title="Run command">
    SELECT SUM(population2020.this) AS total_population
    FROM population2020;
    </code>

    You should see the following:

    ```
    +--------------------+
    |    total_population|
    +--------------------+
    |            16052892|
    +--------------------+
    ```

1. Filter for cities that had a population of more than 1,000,000 in 2020.

    ```sql
    SELECT population2020.__key AS large_cities
    FROM population2020
    GROUP BY population2020.__key HAVING SUM(population2020.this) > 1000000;
    ```

    ```
    +--------------------+
    |large_cities        |
    +--------------------+
    |Prague              |
    |London              |
    |Ankara              |
    +--------------------+
    ```

    The `HAVING` clause allows you to filter aggregations like you would with the `WHERE` clause for non-aggregated queries.