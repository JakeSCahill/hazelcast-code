To save your query results as a view that you can later access faster, you can cache them in Hazelcast by ingesting them into a map.

1. Create a mapping to a new map in which to ingest your streaming query results.

  <code class="execute T5" title="Run command">
  CREATE MAPPING trade_map (
  __key BIGINT,
  ticker VARCHAR,
  company VARCHAR,
  amount BIGINT)
  TYPE IMap
  OPTIONS (
  'keyFormat'='bigint',
  'valueFormat'='json-flat');
  </code>

1. Submit a streaming job to your cluster that will monitor your `trade` topic for changes and store them in a map.

  <code class="execute T5" title="Run command">
  CREATE JOB ingest_trades AS
  SINK INTO trade_map
  SELECT trades.id, trades.ticker, companies.company, trades.amount
  FROM trades
  JOIN companies
  ON companies.ticker = trades.ticker;
  </code>

  **Note:** A streaming job will run indefinitely until it is explicitly canceled or the cluster is shut down. Even if you kill the shell connection, the job will continue running on the cluster.

1. Open another SQL shell.

    `docker run --network hazelcast-network -it --rm hazelcast/hazelcast hz-cli --targets hello-world@172.19.0.2 sql`{{execute T6}}

1. List your job to make sure that it was successfully submitted.

  <code class="execute T6" title="Run command">
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

1. Publish some messages to the Kafka topic.

  <code class="execute T6" title="Run command">
  INSERT INTO trades VALUES
  (1, 'ABCD', 5.5, 10),
  (2, 'EFGH', 14, 20);
  </code>

1. Query your `trade_map` map to see that the Kafka messages have been added to it.

  <code class="execute T6" title="Run command">
  SELECT * FROM trade_map;
  </code>

  You should see that the data coming from the Kafka broker is being stored in your map.

  ```
  +---------+---------+----------+------------+
  |       id|ticker   |     price|      amount|
  +---------+---------+----------+------------+
  |        2|EFGH     |14.000000…|          20|
  |        1|ABCD     |5.5000000…|          10|
  +---------+---------+----------+------------+
  ```