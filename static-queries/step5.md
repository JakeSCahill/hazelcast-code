Batch queries allow you to query large datasets either in one or multiple systems and/or run aggregations on them to get deeper insights. Usually these queries are complex and you can run a small number of them concurrently in a Hazelcast cluster.

1. Use the `SUM()` function to aggregate the total number of likes for each person and group the results by name.

    <code class="execute T2" title="Run command">
    SELECT name, sum(likes) AS total_likes FROM csv_likes GROUP BY name;
    </code>
    
    You should see the following:
  
    ```
    +--------------------+--------------------+
    |name                |         total_likes|
    +--------------------+--------------------+
    |Greg                |                 108|
    |Jerry               |                 101|
    |Mary                |                  73|
    +--------------------+--------------------+
    ```
    
    The results do not include a row for each Jerry because the `GROUP BY` statement groups the results by name.

1. Filter for the names that have more than 100 likes combined, using the `HAVING` clause. This clause is equivalent to the `WHERE` clause but for aggregate groups.

    <code class="execute T2" title="Run command">
    SELECT name AS most_liked
    FROM csv_likes
    GROUP BY name HAVING SUM(likes) > 100;
    </code>
    
    ```
    +--------------------+
    |most_liked          |
    +--------------------+
    |Jerry               |
    |Greg                |
    +--------------------+
    ```