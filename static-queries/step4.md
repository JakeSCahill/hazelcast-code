In this step, you use SQL to get data from a [Kafka](https://kafka.apache.org/) topic and display the results of a query.

The data that you will push to Kafka will be JSON messages with trading information such as the following:

```json
{
    "id": 1,
    "ticker": "ABCD",
    "price": 5.5,
    "amount": 10
}
```

1. Start a Kafka server.

  <code class="execute T3" title="Run command">
  docker run --name kafka --network hazelcast-network --rm hazelcast/hazelcast-quickstart-kafka
  </code>

1. In the SQL shell, `CREATE MAPPING` statement to allow Hazelcast to access data that is pushed to the Kafka server.

  <code class="execute T2" title="Run command">
  CREATE MAPPING trades (
      id BIGINT,
      ticker VARCHAR,
      price DECIMAL,
      amount BIGINT)
  TYPE Kafka
  OPTIONS (
      'valueFormat' = 'json',
      'bootstrap.servers' = 'kafka:9092'
  );
  </code>

1. Write a streaming query that filters trade events from Kafka and adds them to a table.

  <code class="execute T2" title="Run command">
  SELECT ticker, ROUND(price * 100) AS price_cents, amount
  FROM trades
  WHERE price * amount > 100;
  </code>

  ```
  +------------+----------------------+-------------------+
  |ticker      |           price_cents|             amount|
  +------------+----------------------+-------------------+
  ```
  
  Streaming queries like this one continue to run until you close the shell or kill the process with **Ctrl** + **C**.

1. Open another SQL shell.

  `docker run --network hazelcast-network -it --rm hazelcast/hazelcast:5.0-SNAPSHOT hazelcast --targets hello-world@172.19.0.2 sql`{{execute T4}}

1. In the new SQL shell, add some messages to the Kafka topic.

  <code class="execute T4" title="Run command">
  INSERT INTO trades VALUES
  (1, 'ABCD', 5.5, 10),
  (2, 'EFGH', 14, 20);
  </code>

. Go back to the terminal where you created the streaming query.

  You should see that Hazelcast has executed the query and filtered the results:

  ```
  +-----------------+----------------------+-------------------+
  |ticker           |           price_cents|             amount|
  +-----------------+----------------------+-------------------+
  |EFGH             |                  1400|                 20|
  ```
