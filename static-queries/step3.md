In this step, you load data from a `.csv` file that has the following contents:

```
id,name,likes
1,Jerry,13
2,Greg,108
3,Mary,73
4,Jerry,88
```

1. . Use the `CREATE MAPPING` statement to give Hazelcast access to the data in the `likes.csv` file.

    ```sql
    CREATE MAPPING csv_likes (id INT, name VARCHAR, likes INT)
    TYPE File
    OPTIONS ('format'='csv',
        'path'='/usr/local/bin/hazelcast-5.0-SNAPSHOT/bin/csv-dir', 'glob'='likes.csv');
    ```

    **Note:** Hazelcast SQL does not have a native storage system. Instead it uses external mappings to access various resources as if they were tables.

1. Use the `SELECT` statement to query all the data in the `likes.csv` file.

    ```sql
    SELECT * FROM csv_likes;
    ```

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

1. Use the `SELECT` statement to query the `name` column and to aggregate the total number of likes for each person.

    ```sql
    SELECT name, sum(likes) AS total_likes FROM csv_likes GROUP BY name;
    ```
    
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