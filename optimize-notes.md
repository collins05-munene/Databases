# Optimize

## Index
    A structure used to speed up the retrieval of rows from a table

    <> CREATE INDEX "title_index" ON "movies" ("title");
    <> SELECT * FROM "movies" WHERE "title" = 'Cars';

### Check if SQLite used the index

    <> EXPLAIN QUERY PLAN
        SELECT * FROM "movies" WHERE "title" = 'Cars';

### Remove an Index
    <> DROP INDEX "title_index";

