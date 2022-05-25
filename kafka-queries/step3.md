Connect to the SQL service of your cluster member.

`docker run --network hazelcast-network -it --rm hazelcast/hazelcast hz-cli --targets hello-world@172.17.0.2 sql`{{execute T3}}
