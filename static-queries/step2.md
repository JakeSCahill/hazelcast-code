Click the text below to start the SQL shell

`docker run -v csv-dir:/csv-dir --network hazelcast-network -it --rm hazelcast/hazelcast:5.0-SNAPSHOT hazelcast --targets hello-world@172.19.0.2 sql`{{execute T2}}