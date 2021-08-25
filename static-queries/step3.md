In this step, you use the file connector to create a mapping to a CSV file, which has the following contents:

```
id,name,likes
1,Jerry,13
2,Greg,108
3,Mary,73
4,Jerry,88
```

Create a mapping to the file to give Hazelcast access to the data in the `likes.csv` file.

<code class="execute T2" title="Run command">
CREATE MAPPING csv_likes (id INT, name VARCHAR, likes INT) TYPE File OPTIONS ('format'='csv','path'='/csv-dir', 'glob'='likes.csv');
</code>

```
OK
```