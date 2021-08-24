Federated queries are those that join tables from different datasets.

Normally, querying in SQL is database or dataset-specific. However, with Hazelcast, you can pull information from different sources and present a more complete picture of the data.

1. Configure the map connector to create a new table called `dislikes`.

    <code class="execute T2" title="Run command">
    CREATE MAPPING dislikes (
    name VARCHAR,
    dislikes INT
    ) TYPE IMap OPTIONS ('keyFormat'='int', 'valueFormat'='json');
    </code>

    This table is mapped to a distributed map in Hazelcast where the key is an integer and the value is an object that's serialized to JSON.

1. Use `SINK INTO` statements to add some entries to the map.

    <code class="execute T2" title="Run command">
    SINK INTO dislikes VALUES(1, 'Greg', 1);
    </code>

    <code class="execute T2" title="Run command">
    SINK INTO dislikes VALUES(2, 'Jerry', 0);
    </code>

    <code class="execute T2" title="Run command">
    SINK INTO dislikes VALUES(3, 'Mary', 5);
    </code>

    <code class="execute T2" title="Run command">
    SINK INTO dislikes VALUES(4, 'Jerry', 0);
    </code>

1. Use the `JOIN` clause to merge results from the `likes` and `dislikes` tables so you can see who has the most likes and dislikes.

    **Note:** The data source on the right of the join must always be a map.

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

1. Use the `ORDER BY` clause to order the results by name and use the `LIMIT` clause to limit them so that only the first two are displayed.

    <code class="execute T2" title="Run command">
    SELECT csv_likes.name, csv_likes.likes, dislikes.dislikes
    FROM csv_likes
    JOIN dislikes
    ON csv_likes.id = dislikes.__key
    ORDER BY csv_likes.name
    LIMIT 2;
    </code>