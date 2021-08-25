Before you can query data in a map, you need to create a mapping to one with the map connector.

1. Create a mapping to a new map called `cities`.

    <code class="execute T2" title="Run command">
    CREATE MAPPING cities
    TYPE IMap OPTIONS ('keyFormat'='varchar', 'valueFormat'='varchar');
    </code>

1. Add some countries and their capital cities to the map.

    <code class="execute T2" title="Run command">
    INSERT INTO cities VALUES
    ('Australia','Canberra'),
    ('Croatia','Zagreb'),
    ('Czech Republic','Prague'),
    ('England','London'),
    ('Turkey','Ankara'),
    ('United States','Washington, DC');
    </code>

    The first argument of the `VALUES` command is the key of the map entry and the second argument is the value.