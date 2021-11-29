To save your query results as a view, you can cache them in Hazelcast by ingesting them into a map.

1. Configure the map connector to create a new table called `likes_and_dislikes`.

  <code class="execute T2" title="Run command">
  CREATE MAPPING likes_and_dislikes (
  __key INT,
  name VARCHAR,
  likes INT,
  dislikes INT
  ) TYPE IMap OPTIONS ('keyFormat'='int', 'valueFormat'='json-flat');
  </code>

  This table is mapped to a distributed map in Hazelcast where the key is an integer and the value is an object that's serialized to JSON.

1. Run the `JOIN` query to merge results from the CSV file and the `dislikes` map and insert them into the `likes_and_dislikes` map.

  <code class="execute T2" title="Run command">
  INSERT INTO likes_and_dislikes SELECT csv_likes.msg_id, names.this, csv_likes.likes, csv_likes.dislikes
  FROM csv_likes
  JOIN names
  ON csv_likes.msg_id = names.__key;
  </code>

1. Make sure that the query results were added to the map.

  <code class="execute T2" title="Run command">
  SELECT * FROM likes_and_dislikes
  ORDER BY __key;
  </code>

  ```
  +------------+--------------------+------------+------------+
  |       __key|name                |       likes|    dislikes|
  +------------+--------------------+------------+------------+
  |           1|Greg                |          20|          13|
  |           2|Jerry               |         108|          25|
  |           3|Mary                |         122|          73|
  |           4|Jerry               |           9|          88|
  |           5|Joe                 |          51|          42|
  +------------+--------------------+------------+------------+
  ```