1. Write a streaming query that filters trade events from Kafka and adds them to a table.

    <code class="execute T3" title="Run command">
    SELECT ticker, ROUND(price \* 100) AS price_cents, amount
    FROM trades
    WHERE price \* amount > 100;
    </code>

    ```
    +------------+----------------------+-------------------+
    |ticker      |           price_cents|             amount|
    +------------+----------------------+-------------------+
    ```
    
    Streaming queries like this one continue to run until you close the shell or kill the process with **Ctrl** + **C**.

1. Open another SQL shell.

    `docker run --network hazelcast-network -it --rm hazelcast/hazelcast:latest hazelcast --targets hello-world@172.19.0.2 sql`{{execute T4}}

1. In the new SQL shell, add some messages to the Kafka topic.

    <code class="execute T4" title="Run command">
    INSERT INTO trades VALUES
    (1, 'ABCD', 5.5, 10),
    (2, 'EFGH', 14, 20);
    </code>
    
1. Go back to terminal 3 where you created the streaming query.

    You should see that Hazelcast has executed the query and filtered the results:

    ```
    +-----------------+----------------------+-------------------+
    |ticker           |           price_cents|             amount|
    +-----------------+----------------------+-------------------+
    |EFGH             |                  1400|                 20|
    ```
