As well as querying and transforming data, you can ingest results into other systems, including Hazelcast maps to avoid running redundant queries.

However, because Kafka is a streaming source, your query continues to run until it is canceled and results are returned to the SQL shell as soon as they are ready.

To be able to ingest data, you need to set up a _job_ to allow the streaming query to run in the background and send the results elsewhere.

1. Create a mapping to a new map in which to store your streaming query results.

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

1. Submit a streaming job to your cluster that will monitor your Kafka topic (`SELECT id, ticker, price, amount FROM trades`) for changes and store them in a map (`SINK INTO tradeMap`).

    <code class="execute T4" title="Run command">
    CREATE JOB ingest_trades AS
    SINK INTO tradeMap
    SELECT id, ticker, price, amount
    FROM trades;
    </code>

    **Note:** A streaming job will run indefinitely until it is explicitly canceled or the cluster is shut down. Even if you kill the shell connection, the job will continue running on the cluster.

1. List your job to make sure that it was successfully submitted.

    <code class="execute T4" title="Run command">
    SHOW JOBS;
    </code>

    You should see a job called `ingest_trades`.

    ```
    +--------------------+
    |name                |
    +--------------------+
    |ingest_trades       |
    +--------------------+
    ```

1. Publish some events to the Kafka topic.

    <code class="execute T4" title="Run command">
    INSERT INTO trades VALUES
    (1, 'ABCD', 5.5, 10),
    (2, 'EFGH', 14, 20);
    </code>

1. Query your `tradeMap` map to see that the Kafka data has been added to it.

    <code class="execute T4" title="Run command">
    SELECT * FROM tradeMap;
    </code>

    You should see that the data coming from Kafka is being stored in your map.

    ```
    +---------+---------+----------+------------+
    |       id|ticker   |     price|      amount|
    +---------+---------+----------+------------+
    |        2|EFGH     |14.000000…|          20|
    |        1|ABCD     |5.5000000…|          10|
    +---------+---------+----------+------------+
    ```

1. To stop your streaming job, use the `DROP` statement to cancel it.

    <code class="execute T4" title="Run command">
    DROP JOB ingest_trades;
    </code>

    In the terminal where you started the Hazelcast member, you should see that the job is canceled as well as the time it was started and how long it ran for.

    ```
    Execution of job '062d-d578-9240-0001', execution 062d-d578-df80-0001 got terminated, reason=java.util.concurrent.CancellationException
        Start time: 2021-05-13T16:31:14.410
        Duration: 00:02:48.318
    ```