Ad-hoc queries allow you to retrieve a small subset of data. Usually these queries are simple and you can have many of them running concurrently in a Hazelcast cluster.


1. Query all the data in the `likes.csv` file.

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

1. Query only the `name` and `likes` columns, by adding them as a comma-separated list after the `SELECT` statement.

    <code class="execute T2" title="Run command">
    SELECT name, likes FROM csv_likes;
    </code>

    ```
    +--------------------+------------+
    |name                |       likes|
    +--------------------+------------+
    |Jerry               |          13|
    |Greg                |         108|
    |Mary                |          73|
    |Jerry               |          88|
    +--------------------+------------+
    ```

1. Use a filter to display only the names of people with more than 20 likes.

    <code class="execute T2" title="Run command">
    SELECT name FROM csv_likes WHERE likes > 20;
    </code>

    ```
    +--------------------+
    |name                |
    +--------------------+
    |Greg                |
    |Mary                |
    |Jerry               |
    +--------------------+
    ```

1. Give the `name` column an alias for the query results.

    **Note:** This clause does not rename the column in the table.

    <code class="execute T2" title="Run command">
    SELECT name AS popular_users, likes
    FROM csv_likes
    WHERE likes > 20;
    </code>
    
    ```
    +--------------------+------------+
    |popular_users       |       likes|
    +--------------------+------------+
    |Greg                |         108|
    |Mary                |          73|
    |Jerry               |          88|
    +--------------------+------------+
    ```

1. To filter rows on more than one condition, you can join conditions with the `AND`, `OR`, and `NOT` operators.

    <code class="execute T2" title="Run command">
    SELECT *
    FROM csv_likes
    WHERE likes > 20 AND name = 'Mary';
    </code>

    ```
    +------------+--------------------+------------+
    |          id|name                |       likes|
    +------------+--------------------+------------+
    |           3|Mary                |          73|
    +------------+--------------------+------------+
    ```