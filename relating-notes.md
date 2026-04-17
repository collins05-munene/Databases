# Relating

   ## One to One Relationship
    . One author writes one book and one book is written by one author

   ## One to Many Relationship
   
    . One author writes many books

   ## Many to Many Relationship
    .Many books written by many authors

   ## Entity Relationship Diagrams

   ### ZERO
         -----------O--   

   ### ONE
                    |
        . --------------      
                    |

   ### MANY
                    /
        . --------------     
                    \    


   ## Keys
    - Primary Key: 
    - Foreign Key: Taking a Primary Key from table(1) and including it in he some colummn of table(2)
    - Used for One { table(1) } to Many { table(2) } relationships.

    - Many to Many relationship: Take id's from diffrent tables and put them in one table. Table 1 & Table 2 into Table 3

   ## SubQueries / Nested Queries
    One to Many:
        <> SELECT "title" FROM "books" WHERE "publisher_id" = (
                SELECT "id" FROM "publishers"
                WHERE "publisher"= 'Fitzcarraldo Editions'
            );

        <> SELECT AVG("rating") FROM "ratings" WHERE "book_id" = (
                SELECT "id" FROM "books" WHERE "title" = 'In Memory of Memory'
            );

        <> SELECT ROUND(AVG("rating"), 2) FROM "ratings" WHERE "book_id" = (
                SELECT "id" FROM "books" WHERE "title" = 'In Memory of Memory'
            );
    
    Many to Many:
        <> SELECT "name" FROM "authors" WHERE "id" = (
                SELECT "author_id" FROM "authored" WHERE "book_id" = (
                    SELECT "id" FROM "books" WHERE "title" = "Flights"
                )
            );
            . author_name of with author_id of book Flights

        IN:
            <> SELECT "title" FROM "books" WHERE "id" IN (
                    SELECT "book_id" FROM "authored" WHERE "author_id" = (
                        SELECT "id" FROM "authors" WHERE "name" = 'Fernanda Melchor'
                    )
                );  
                . GET two books since Fernanda has two books

        JOIN: 
            Combining data from two tables {INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN, NATURAL JOIN}

            <> SELECT * FROM "sea_lions" JOIN "migrations" ON "migrations"."id" = "sea_lions"."id";
                Returns rows with full match

            <> SELECT * FROM "sea_lions" LEFT JOIN "migrations" ON "migrations"."id" = "sea_lions"."id";
                Returns full left table and the right table only those that match are returned

            <> SELECT * FROM "sea_lions" RIGHT JOIN "migrations" ON "migrations"."id" = "sea_lions"."id";
                Return full right table ros and ommits the left table rows that aren't matching

            <> SELECT * FROM "sea_lions" FULL JOIN "migrations" ON "migrations"."id" = "sea_lions"."id";
                Returns everything

            <> SELECT * FROM "sea_lions" NATURAL JOIN "migrations";
   ## Sets
        Keywords:
            Intersect Operators -> Both author and translator
            Union -> Combine sets
            Except -> Returns author only and translator only not whose both

        <> SELECT 'author' AS 'profession', "name" FROM "authors"
            UNION
            SELECT 'translator' AS "profession", "name" FROM "translators";

        <> SELECT "name" FROM "authors"
            INTERSECT
            SELECT "name" FROM "translators";

        <> SELECT "name" FROM "authors"
            EXCEPT
            SELECT "name" FROM "translators";

        <> SELECT "book_id" FROM "translated" WHERE "translator_id" = (
                SELECT "id" FROM "translators" WHERE "name" = 'Sophie Hughes'
            )
            INTERSECT
            SELECT "book_id" FROM "translated" WHERE "translator_id" = (
                SELECT "id" FROM "translators" WHERE "name" = 'Margaret Jull Costa'
            );
             . Books translated by both

   ## Groups
        Keywords:
            GROUP BY
            HAVING

        <> SELECT "book_id", AVG("rating") AS "average rating" FROM "ratings"
            GROUP BY "book_id"; 

        <> SELECT "book_id", COUNT("rating") AS "Number of ratings" FROM "ratings"
            GROUP BY "book_id"; 

        <> SELECT "book_id", AVG("rating") AS "average rating" FROM "ratings"
            GROUP BY "book_id"
            HAVING "average rating" > 4.0; 

        <> SELECT "book_id", ROUND(AVG("rating"), 2) AS "average rating" FROM "ratings"
            GROUP BY "book_id"
            HAVING "average_rating" > 4.0
            ORDER BY "average rating" DESC;

