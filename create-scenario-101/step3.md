Hazelcast SQL allows you to create IMaps on a local cluster.

Here, you create an IMap called _myMap_ that stores a `name` field and an `age` field.

```sql
CREATE MAPPING myMap (
    id BIGINT EXTERNAL NAME "__key",
    name VARCHAR,
    age INT)
TYPE IMap
OPTIONS (
    'keyFormat'='bigint',
    'valueFormat'='json');
```

**Note:** Identifiers such as table and column names are case-sensitive. If your identifier contains special characters, wrap them in double quotes ("").

The `keyFormat` and `valueFormat` options are mandatory and each option may contain one of the following values:

- Any of the supported SQL data types except OBJECT
- `portable`
- `json`
- `java`