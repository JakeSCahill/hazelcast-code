As well as querying and transforming data, you can store your query results. This feature is useful for sending results to other systems or caching results in Hazelcast to avoid running redundant queries.

In this step, you create a mapping to a map named `tradeMap` and store some trade data in it as JSON.

1. Use the `CREATE MAPPING` statement to create a mapping to a new map.

    <code class="execute T4" title="Run command">
    CREATE MAPPING tradeMap (
        __key BIGINT,
        ticker VARCHAR,
        price DECIMAL,
        amount BIGINT)
    TYPE IMap
    OPTIONS (
        'keyFormat'='bigint',
        'valueFormat'='json');
    </code>

1. Use the `SINK INTO` statement to store the results of a query in the map.

    <code class="execute T4" title="Run command">
    SINK INTO tradeMap VALUES (1, 'hazl', 10, 1);
    </code>

1. Query the map to make sure that the data is there.

    <code class="execute T4" title="Run command">
    SELECT * FROM tradeMap;
    </code>

    You should see the following:

    ```
    +-----+----------+--------+--------+
    |__key|ticker    |   price|  amount|
    +-----+----------+--------+--------+
    |    1|hazl      |10.0000…|       1|
    +-----+----------+--------+--------+
    ```