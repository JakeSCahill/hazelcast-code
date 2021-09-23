Connect to the SQL service of your cluster member.

Click the text below twice: Once to open a new terminal, and again to execute the command.

`docker run --network hazelcast-network -it --rm hazelcast/hazelcast hz-cli --targets hello-world@172.19.0.2 sql`{{execute T2}}
