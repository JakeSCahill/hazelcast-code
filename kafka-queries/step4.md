Create a mapping to your Kafka broker.

<code class="execute T3" title="Run command">
CREATE MAPPING trades (
    id BIGINT,
    ticker VARCHAR,
    price DECIMAL,
    amount BIGINT)
TYPE Kafka
OPTIONS (
    'valueFormat' = 'json-flat',
    'bootstrap.servers' = 'kafka:9092'
);
</code>

The `valueFormat` option is JSON because the data that you will push to Kafka will be JSON messages with trading information such as the following:

```json
{
    "id": 1,
    "ticker": "ABCD",
    "price": 5.5,
    "amount": 10
}
```

The `bootstrap.servers` option is the address of the Kafka broker to allow Hazelcast to connect to it. In this example, the broker is running in a Docker container called `kafka` on port 9092.

