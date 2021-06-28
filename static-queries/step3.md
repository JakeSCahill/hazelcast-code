In this step, you load and query data from a CSV file, which has the following contents:

```
id,name,likes
1,Jerry,13
2,Greg,108
3,Mary,73
4,Jerry,88
```

1. Use the `CREATE MAPPING` statement to give Hazelcast access to the data in the `likes.csv` file.

    <code class="execute T2" title="Run command">
    CREATE MAPPING csv_likes (id INT, name VARCHAR, likes INT) TYPE File OPTIONS ('format'='csv','path'='/csv-dir', 'glob'='likes.csv');
    </code>

    ```
    OK
    ```

    **Note:** Hazelcast SQL does not have a native storage system. Instead, it uses external mappings to access various resources as if they were tables.

1. Use the `SELECT` statement to query all the data in the `likes.csv` file.

    <code class="execute T2" title="Run command">
    SELECT * FROM csv_likes;
    </code>

    You should see the following:

    ```
    +------------+--------------------+------------+
    |          id|name                |       likes|
    +------------+--------------------+------------+
    |           1|Jerry               |          13|
    |           2|Greg                |         108|
    |           3|Mary                |          73|
    |           4|Jerry               |          88|
    +------------+--------------------+------------+
    ```

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

    The results do not include a rows for each Jerry because the `GROUP BY` statement groups the results by name.

1. Create a mapping to a new table called `dislikes`.

    <code class="execute T2" title="Run command">
    CREATE MAPPING dislikes (
    name VARCHAR,
    dislikes INT
    ) TYPE IMap OPTIONS ('keyFormat'='int', 'valueFormat'='json');
    </code>

    ```
    OK
    ```

    This table is mapped to a distributed map in Hazelcast where the key is an integer and the value is an object that's serialized in JSON.

1. Use the `SINK INTO` statement to add some data to the map.

    <code class="execute T2" title="Run command">
    SINK INTO dislikes VALUES(1, 'Greg', 1);
    SINK INTO dislikes VALUES(2, 'Jerry', 0);
    SINK INTO dislikes VALUES(3, 'Mary', 5);
    SINK INTO dislikes VALUES(4, 'Jerry', 0);
    </code>

    ```
    OK
    ```

1. Use the `JOIN` clause to merge results from the `likes` and `dislikes` tables so you can see who has the most likes and dislikes.

    <code class="execute T2" title="Run command">
    SELECT csv_likes.name, csv_likes.likes, dislikes.dislikes
    FROM csv_likes
    JOIN dislikes
    ON csv_likes.id = dislikes.__key;
    </code>

    ```
    +--------------------+------------+------------+
    |name                |       likes|    dislikes|
    +--------------------+------------+------------+
    |Jerry               |          13|           0|
    |Greg                |         108|           5|
    |Mary                |          73|           5|
    |Jerry               |          88|          20|
    +--------------------+------------+------------+
    ```

1. Use the `ORDER BY` statement to order the results by name and use the `LIMIT` clause to limit them so that only the first two are displayed.

    <code class="execute T2" title="Run command">
    SELECT csv_likes.name, csv_likes.likes, dislikes.dislikes
    FROM csv_likes
    JOIN dislikes
    ON csv_likes.id = dislikes.__key
    ORDER BY csv_likes.name
    LIMIT 2;
    </code>