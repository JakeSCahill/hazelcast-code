Kafka messages are often small and contain minimal data to reduce network latency. For example, the `trades` topic does not contain any information about the company that's associated with a given ticker. To get deeper insights from data in Kafka topics, you can join query results with data in other mappings.

1. Create a mapping to a new map in which to store the company information that you'll use to enrich results from the `trades` topic.

    <code class="execute T4" title="Run command">
    CREATE MAPPING companies (
    __key BIGINT,
    ticker VARCHAR,
    company VARCHAR,
    marketcap BIGINT)
    TYPE IMap
    OPTIONS (
    'keyFormat'='bigint',
    'valueFormat'='json-flat');
    </code>

1. Add some entries to the `companies` map.

    <code class="execute T4" title="Run command">
    INSERT INTO companies VALUES
    (1, 'ABCD', 'The ABCD', 100000),
    (2, 'EFGH', 'The EFGH', 5000000);
    </code>

1. Use the xref:sql:select.adoc#join-tables[`JOIN` clause] to merge results from the `companies` map and `trades` topic so you can see which companies are being traded.

    <code class="execute T4" title="Run command">
    SELECT trades.ticker, companies.company, trades.amount
    FROM trades
    JOIN companies
    ON companies.ticker = trades.ticker;

    ```
    +------------+-----------+----------+
    |ticker      |company    |    amount|
    +------------+-----------+----------+
    ```

1. In another SQL shell, publish some messages to the `trades` topic.

    <code class="execute T5" title="Run command">
    INSERT INTO trades VALUES
    (1, 'ABCD', 5.5, 10),
    (2, 'EFGH', 14, 20);
    </code>

1. Go back to terminal 4 where you created the streaming query that merges results from the `companies` map and `trades` topic.

    You should see that Hazelcast has executed the query.

    ```
    +------------+-----------+----------+
    |ticker      |company    |    amount|
    +------------+-----------+----------+
    |ABCD        |The ABCD   |10        |
    |EFGH        |The EFGH   |20        |
    ```
