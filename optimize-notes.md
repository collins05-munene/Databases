# Optimize

## Indexing
    A structure used to speed up the retrieval of rows from a table

    <> CREATE INDEX "title_index" ON "movies" ("title");
    <> SELECT * FROM "movies" WHERE "title" = 'Cars';

### Check if SQLite used the index

    <> EXPLAIN QUERY PLAN
        SELECT * FROM "movies" WHERE "title" = 'Cars';

### Remove an Index
    <> DROP INDEX "title_index";

### Covering Index
    An index in which queried data can be retrieved from the index itself.

    <> CREATE INDEX "person_index" ON "stars" ("person_id", "movie_id");

    <> EXPLAIN QUERY PLAN
        SELECT "title" FROM "movies" WHERE "id" IN (
            SELECT "movie_id" FROM "stars" WHERE "person_id" = (
                SELECT "id" FROM "people" WHERE "name" = 'Tom Hank'
            )
        );

### Why index take up so much space;
    . B-Tree
       - A balanced tree structure commonly used to create an index.
       - A tree is made up of a collections of nodes and each node stores some values also each node stores some pointers to other nodes to tell us in       memory where other nodes are.
       - Leaf node a node that points to no other node / the last node

    Binary Search
        Binary search is a highly efficient algorithm used to find the position of a target value within a sorted array or list. It operates on the "divide and conquer" principle, repeatedly halving the search space until the value is found or the list is exhausted.

## Partial Index
    An index that includes only a subset of rows from a table.
    SYNTAX
        CREATE INDEX name 
                ON TABLE (column0,...)
                WHERE condition;

        <> CREATE INDEX "recents" ON "movies" ("title")
            WHERE "year" = 2023;

            works when; 
                SELECT "title" FROM "movies" WHERE "year" = 2023;
            but this will scan;
                SELECT "title" FROM "movies" WHERE "year" = 2001;

## Vacuum
    - Taking unused bits and giving them back to the operating system.
    - When we delete an index, we drop the index. We don't actually shrink our db file. We just mark those bits that were part of the index as being           available for re-use.

    <> du -b {database name}
        Check the bytes used

    <> VACUUM;

## Concurrency
    Getting multpile queries, multiple interactions all at roughly the same time and my computer system, my db needs to figure out how to handle all of those at once. Controlling traffic.

### Transaction
    - A unit of work in a database. It can't be broken down into smaller pieces.
    - It has several properties and it helps implement several properties of a database;
        . ACID -> Atomicity Consistency Isolation Durability

    SYNTAX:
        <> BEGIN TRANSACTION;
            ...
            COMMIT;
        
        Example of atomicity:

            <> BEGIN TRANSACTION;
                UPDATE "accounts" SET "balance" = "balance" + 10
                WHERE "id" = 2;
                UPDATE "accounts" SET "balance" = "balance" - 10
                WHERE "id = 1;
                COMMIT;
        
        Undoing a transaction using Rollback when we've hit inconsistency:
            <> BEGIN TRANSACTION;
                UPDATE "accounts" SET "balance" = "balance" + 10
                WHERE "id" = 2;
                UPDATE "accounts" SET "balance" = "balance" - 10
                WHERE "id = 1;
                    (Here you'll hit a runtime error, after that you rollback)
                ROLLBACK;

        Race conditions:
            - When we have multiple people, multiple processes trying to access some value and also making a decision based on that value and if unaddressed it can lead to a scenario that's inconsistent in our db.

            . Locks - Unlocked -> Any body can read and update
                    - Shared -> Only reading and you too could only read when am reading
                    - Exclusive ->  Can't let anybody read my data when am updating

                    <> BEGIN EXCLUSIVE TRANSACTION; Locking entire db
