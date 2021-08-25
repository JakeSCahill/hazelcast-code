Before you can query data in a map, you need to create a mapping to one with the map connector.

1. Create a mapping to a new map called `cities`.

    <code class="execute T2" title="Run command">
    CREATE MAPPING cities
    TYPE IMap OPTIONS ('keyFormat'='varchar', 'valueFormat'='varchar');
    </code>

1. Add some countries and their capital cities to the map.

    <code class="execute T2" title="Run command">
    INSERT INTO cities VALUES ('Australia','Canberra');
    </code>

    <code class="execute T2" title="Run command">
    INSERT INTO cities VALUES ('Croatia','Zagreb');
    </code>

    <code class="execute T2" title="Run command">
    INSERT INTO cities VALUES ('Czech Republic','Prague');
    </code>

    <code class="execute T2" title="Run command">
    INSERT INTO cities VALUES ('England','London');
    </code>

    <code class="execute T2" title="Run command">
    INSERT INTO cities VALUES ('Turkey','Ankara');
    </code>

    <code class="execute T2" title="Run command">
    INSERT INTO cities VALUES ('United States','Washington, DC');
    </code>

    The first argument of the `VALUES` command is the key of the map entry and the second argument is the value.