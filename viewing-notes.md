# View 
    A virtual tale defined by a query, combination of data from underlying tables.

## Why use a View:
    . Simplify data
    . Aggregate Data
    . Partition Data
    . Secure Data
    ...
    {authors} {authored} {books}

### Simplify

    -> Old Version Without View:
        <>  SELECT "title" FROM "books" 
            WHERE "id" IN (
                SELECT "book_id" FROM "authored" 
                WHERE "author_id" = (
                    SELECT "id" FROM "authors" WHERE "name" = 'Fernanda Melchor';SELECT "id" FROM "aauthors" WHERE "name" = 'Fernanda Melchor'
            )
            );
    
    -> New Version With View:
            What view does:
                <> SELECT "name", "title" FROM "authors"
                    JOIN "authored" ON "authors"."id" = "authored"."id"
                    JOIN "books" ON "books"."id" = "authored"."id";
            View:
                <> CREATE VIEW "longlist" AS 
                    SELECT "name", "title" FROM "authors"
                    JOIN "authored" ON "authors"."id" = "authored"."id"
                    JOIN "books" ON "books"."id" = "authored"."id";
                
                <> CREATE VIEW "average_book_ratings" AS
                    SELECT "book_id", "title", "year", ROUND(AVG("rating"), 2) AS "rating"
                    FROM "ratings"
                    JOIN "books" ON "ratings"."book_id" = "books"."id"
                    GROUP BY "book_id"; 

                <> CREATE TEMPORARY VIEW "average_book_ratings_by_year"  AS
                    SELECT "year", ROUND(AVG("rating"), 2) AS "rating" FROM "average_book_ratings"
                    GROUP BY "year";

                    Temporary view creates a temporary view that exists only during the duration  of connection with the db. Once the db is exited the temporary view is deleted. Meaning next time you open the db the view won't be available.

### Aggregate

#### CTE - Common Table Expression
    SYNTAX:    
            WITH name AS (
                SELECT ...
                ), ...
                SELECT .. FROM name;
            
    <> WITH "average_book_ratings" AS (
            SELECT "book_id", "title", "year", ROUND(AVG("rating"), 2) AS "rating"
            FROM "ratings"
            JOIN "books" ON "ratings"."book_id" = "books"."id"
            GROUP BY "book_id"
        )
        SELECT "year", ROUND(AVG("rating"), 2) AS "rating"
                FROM "average_book_ratings"
                GROUP BY "year";
    
### Partition
    Break a larger table into logical tables

    <> CREATE VIEW "books_nominated_in_2021" AS
        SELECT "id", "title" FROM "books"
        WHERE "year" = 2021;

### Securing
    <> CREATE VIEW "analysis" AS
        SELECT "id", "origin", "destination", 'Anonymous' AS "rider"
        FROM "rides";

    In sqlite we can't set access control, either give all data or deny all data

### Soft Deletions
    Not deleting items but instead marking them as deleted.

    <> CREATE VIEW "current_collections" AS
        SELECT "title", "accession_number", "acquired"
        FROM "collections" WHERE "deleted" = 0;

    <> CREATE TRIGGER "delete"
        INSTEAD OF DELETE ON "current_collections"
        FOR EACH ROW
        BEGIN
            UPDATE "collections" SET "deleted" = 1
            WHERE "id" = OLD."id";
        END;

    <> CREATE TRIGGER "insert_when_exists"
        INSTEAD OF INSERT ON "current_collections"
        FOR EACH ROW
        WHEN NEW."accession_number" IN (
            SELECT "accession_number" FROM "collections"
        )
        BEGIN
            UPDATE "collections" SET "deleted" = 0
            WHERE "accession_number" = NEW."accession_number";
        END;

        .Trigger to insert into my collections table when I try to insert to insert int0 my view.

