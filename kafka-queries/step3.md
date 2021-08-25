Connect to the SQL service of your cluster member.

`docker run --network hazelcast-network -it --rm hazelcast/hazelcast:5.0-SNAPSHOT hz-cli --targets hello-world@172.19.0.2 sql`{{execute T3}}