Federated queries are those that join tables from different datasets.

Normally, querying in SQL is database or dataset-specific. However, with Hazelcast, you can pull information from different sources and present a more complete picture of the data.

1. Configure the map connector to create a new table called `dislikes`.

    <code class="execute T2" title="Run command">
    CREATE MAPPING names
    TYPE IMap OPTIONS ('keyFormat'='int', 'valueFormat'='varchar');
    </code>

    This table is mapped to a distributed map in Hazelcast where the key is an integer and the value is a string. 

1. Use `SINK INTO` statements to add some entries to the map.

    <code class="execute T2" title="Run command">
    SINK INTO names VALUES
    (1, 'Greg'),
    (2, 'Jerry'),
    (3, 'Mary'),
    (4, 'Jerry'),
    (5, 'Joe');
    </code>

1. Use the `JOIN` clause to merge results from the `messages` and `names` tables so you can see who has the most likes and dislikes.

    **Note:** The data source on the right of the join must always be a map.

    <code class="execute T2" title="Run command">
    SELECT names.this, csv_likes.likes, csv_likes.dislikes
    FROM csv_likes
    JOIN names
    ON csv_likes.msg_id = names.__key;
    </code>

    ```
    +--------------------+------------+------------+
    |this               |       likes|    dislikes|
    +--------------------+------------+------------+
    |Jerry               |         108|          25|
    |Greg                |          20|          13|
    |Jerry               |           9|          88|
    |Joe                 |          51|          42|
    |Mary                |         122|          73|
    +--------------------+------------+------------+
    ```

1. Use the `ORDER BY` clause to order the results by name and use the `LIMIT` clause to limit them so that only the first two are displayed. Change the header of the names column to name.

    <code class="execute T2" title="Run command">
    SELECT names.this AS name, csv_likes.likes, csv_likes.dislikes
    FROM csv_likes
    JOIN names
    ON csv_likes.msg_id = names.__key
    ORDER BY names.this
    LIMIT 2;
    </code>

    ```
    +--------------------+------------+------------+
    |name                |       likes|    dislikes|
    +--------------------+------------+------------+
    |Greg                |          20|          13|
    |Jerry               |           9|          88|
    +--------------------+------------+------------+
    ```

1. Use the `SUM()` function to aggregate the total number of likes for each person and group the results by name.

    <code class="execute T2" title="Run command">
    SELECT names.this AS name, sum(csv_likes.likes) AS total_likes 
    FROM csv_likes 
    JOIN names
    ON csv_likes.msg_id = names.__key
    GROUP BY name;
    </code>

    You should see the following:

    ```
    +--------------------+--------------------+
    |name                |         total_likes|
    +--------------------+--------------------+
    |Greg                |                  20|
    |Mary                |                 122|
    |Joe                 |                  51|
    |Jerry               |                 117|
    +--------------------+--------------------+
    ```

    The results do not include a row for each Jerry because the `GROUP BY` statement groups the results by name.

1. Filter for the names that have more than 100 likes combined, using the `HAVING` clause. This clause is equivalent to the `WHERE` clause but for aggregate groups.

    <code class="execute T2" title="Run command">
    SELECT names.this AS most_liked
    FROM csv_likes 
    JOIN names
    ON csv_likes.msg_id = names.__key
    GROUP BY names.this HAVING SUM(likes) > 100;
    </code>

    ```
    +--------------------+
    |most_liked          |
    +--------------------+
    |Jerry               |
    |Mary                |
    +--------------------+
    ```