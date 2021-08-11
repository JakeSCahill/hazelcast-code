
Hazelcast has lots of distributed data structures available for writing data to memory on your cluster. One of the most popular ways of writing data to memory is to use a distributed map. Maps store key/value pairs called entries, which are replicated and distributed across a cluster.

The quickest way to write some data to a map is to use the CLI console.

1. To start the console, use the following command in a new terminal window:

    `hz-cli console`{{execute T4}}

1. Enter the following to create a map and write some data to it:
    - `ns my-distributed-map`
    - `m.put "1" "John"`
    - `m.put "2" "Mary"`
    - `m.put "3" "Jane"`

    You'll see that each of the `m.put` commands returns `null`, which means that the data was written to the map.

    The `m.put` command returns the previous value that was stored in the given key. Because the map was empty, the previous value was `null`.

1. Exit the console.

    `exit`

1. In Management Center, go to **Storage** > **Maps**.

You should see that your cluster has a map called `my-distributed-map` with three entries. You'll also see the total amount of memory that those entries are taking up in your cluster.
