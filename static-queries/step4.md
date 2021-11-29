Ad-hoc queries allow you to retrieve a small subset of data. Usually these queries are simple and you can have many of them running concurrently in a Hazelcast cluster.


1. Query all the data in the `likes.csv` file.

    <code class="execute T2" title="Run command">
    SELECT * FROM csv_likes;
    </code>

    You should see the following:

    ```
    +------------+------------+------------+
    |      msg_id|       likes|    dislikes|
    +------------+------------+------------+
    |           1|          20|          13|
    |           4|           9|          88|
    |           3|         122|          73|
    |           2|         108|          25|
    |           5|          51|          42|
    +------------+------------+------------+
    ```

1. Query only the `msg_id` and `likes` columns, by adding them as a comma-separated list after the `SELECT` statement.

    <code class="execute T2" title="Run command">
    SELECT msg_id, likes FROM csv_likes;
    </code>

    ```
    +------------+------------+
    |      msg_id|       likes|
    +------------+------------+
    |           1|          20|
    |           3|         122|
    |           4|           9|
    |           2|         108|
    |           5|          51|
    +------------+------------+
    ```

1. Use a filter to display only the message numbers with more than 50 likes.

    <code class="execute T2" title="Run command">
    SELECT msg_id FROM csv_likes WHERE likes > 50;
    </code>

    ```
    +------------+
    |      msg_id|
    +------------+
    |           2|
    |           5|
    |           3|
    +------------+
    ```

1. Give the `msg_id` column an alias for the query results.

    **Note:** This clause does not rename the column in the table.

    <code class="execute T2" title="Run command">
    SELECT msg_id AS message_number, likes, dislikes
    FROM csv_likes
    WHERE likes > 20;
    </code>
    
    ```
    +--------------+------------+------------+
    |message_number|       likes|    dislikes|
    +--------------+------------+------------+
    |             2|         108|          25|
    |             3|         122|          73|
    |             5|          51|          42|
    +--------------+------------+------------+
    ```

1. To filter rows on more than one condition, you can join conditions with the `AND`, `OR`, and `NOT` operators.

    <code class="execute T2" title="Run command">
    SELECT *
    FROM csv_likes
    WHERE likes > 100 OR dislikes < 30;
    </code>

    ```
    +------------+------------+------------+
    |      msg_id|       likes|    dislikes|
    +------------+------------+------------+
    |           1|          20|          13|
    |           2|         108|          25|
    |           3|         122|          73|
    +------------+------------+------------+
    ```