Before you can query data in a map, you need to create a mapping to one with the map connector.

1. Configure the map connector to set up an SQL connection to a new map called `cities`.

    <code class="execute T2" title="Run command">
    CREATE MAPPING cities (
    __key INT, 
    countries VARCHAR, 
    cities VARCHAR)
    type IMap OPTIONS('keyFormat'='int', 'valueFormat'='json-flat');
    </code>

1. Add some cities and countries to the map.

    <code class="execute T2" title="Run command">
    INSERT INTO cities VALUES
    (1, 'United Kingdom','London'),
    (2, 'United Kingdom','Manchester'),
    (3, 'United States', 'New York'),
    (4, 'United States', 'Los Angeles'),
    (5, 'Turkey', 'Ankara'),
    (6, 'Turkey', 'Istanbul'),
    (7, 'Brazil', 'Sao Paulo'),
    (8, 'Brazil', 'Rio de Janeiro');
    </code>

    The first argument of the `VALUES` command is the key of the map entry and the second argument is the value.