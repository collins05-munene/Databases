## Opening the db
    <> sqlite3 longlist.db

## What data is in our database
    ### SELECT KEYWORD
        <> SELECT * FROM "books";
            #### SELECT {all} FROM {table books};

        <> SELECT 'title' FROM "books";
            #### SELECT {column title(s)} FROM {table books};

        <> SELECT 'title', 'author' FROM "books";

    ### LIMIT KEYWORD
        <> SELECT "title" FROM "books" LIMIT 5;
            #### Top 5 books
    
    ### WHERE
        <> SELECT "title", "author" FROM "books" WHERE "year" = 2024;
            #### Year == 2024

        <> SELECT "title", "format" FROM "books" WHERE "format" != 'hardcover';
            #### format != hardcover


        <> SELECT "title", "format" FROM "books" WHERE "format" != 'hardcover';
            #### <> same as !=
        
    ### NOT
        <> SELECT "title", "format" FROM "books" WHERE NOT "format" = 'hardcover';
            #### same result as !=

    ### OR
        <> SELECT "title", "author" FROM "longlist" WHERE "year" = 2022 OR "year" = 2023;
            #### Books nominated in 2022 or 2023

    ### (), AND
        <> SELECT "title", "author" FROM "longlist" WHERE ("year"=2022 OR "year" = 2023) AND "format" != 'hardcover';
            #### Books nominated in 2022 or 2023 and cover is not hardcover
    
    ### IS NULL. IS NOT NULL
        <> SELECT "title", "translator" FROM "books" WHERE "translator" IS NULL;

        <> SELECT "title", "translator" FROM "books" WHERE "translator" IS NOT NULL;

    ### LIKE, %, _
        <> SELECT "title" FROM "longlist" WHERE "title" LIKE '%love%'; 
            #### Books where title is like %love% : Anything before or after love

        <> SELECT "title" FROM "longlist" WHERE "title" LIKE 'The%'; 
            #### Titles that have The at the beginning

        <> SELECT "title" FROM "longlist" WHERE "title" LIKE 'The%love%'; 
            #### The {words} love {words}

        <> SELECT "title" FROM "longlist" WHERE "title" LIKE 'P_re'; 
            #### When you don't know the spelling = Pyre

        <> SELECT "title" FROM "longlist" WHERE "title" LIKE 'T___'; 
            #### Tyll

    ### >, <, >=, <=
        <> SELECT "title", "year" FROM "longlist" WHERE "year" >= 2019 AND "year" <= 2022; 

        <> SELECT "title", "rating" FROM "longlist" WHERE "year" >= 2019 AND "year" <= 2022;

        <> SELECT "title", "rating", "votest" FROM "longlist" WHERE "rating" > 4.0 AND "votes" > 10000; 
    
    ### BETWEEN ... AND ...
        <> SELECT "title", "year" FROM "longlist" WHERE "year" BETWEEN 2019 AND 2022;

    ### ORDER BY
        <> SELECT "title", "rating" FROM "longlist" ORDER BY "rating" LIMIT 10;
            . Ascending order default

        <> SELECT "title", "rating" FROM "longlist" ORDER BY "rating" DESC LIMIT 10;
            . Descending Order

        <> SELECT "title", "rating", "votes" FROM "longlist" ORDER BY "rating" DESC, "votes" DESC LIMIT 10;
            . For books with equal votes that tie breaker will be the number of votes

        <> SELECT "title", "rating" FROM "longlist" ORDER BY "title";
            . Orders by default alphabetically

        <> SELECT "title", "rating" FROM "longlist" ORDER BY "title" DESC;

## SQL Aggregate Functions
    ### AVG
        <> SELECT AVG("rating") FROM "Longlist";
            . Average rating rating for all books

    ### ROUND
        <> SELECT ROUND(AVG("rating"), 2) FROM "Longlist";

    ### AS
        <> SELECT ROUND(AVG("rating"), 2) AS "average rating" FROM "Longlist";
            . Give the title a human readable name "average rating"

    ### MAX
        <> SELECT MAX("rating") FROM "longlist";

    ### MIN
        <> SELECT MIN("rating") FROM "longlist";
    
    ### SUM
        <> SELECT SUM("votes") FROM "longlist";

    ### COUNT 
        <> SELECT COUNT(*) FROM "longlist";
            . returns rows in table

        <> SELECT COUNT("translator") FROM "longlist";

    ### DISTINCT
        <> SELECT DISTINCT "publisher" FROM "loonglist";
            .Trying to find unique values from our column
        
        <> SELECT COUNT(DISTINCT "publisher") FROM "longlist";