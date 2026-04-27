# WRITING
## INSERT INTO
    <> INSERT INTO "collections" ("id", "title", "accession_number", "acquired")
        VALUES (1, 'Profusion of Flowers', '56.257', '1956-04-12');

    <> INSERT INTO "collections" ("id", "title", "accession_number", "acquired")
        VALUES (2, 'Farmers working at dawn', '11.6152', '1911-08-03');

    <> INSERT INTO "collections" ("title", "accession_number", "acquired")
        VALUES ('Spring Outing', '14.76', '1914-01-08');
        .SQLite auto-increments PRIMARY KEYS

    <> INSERT INTO "collections" ("title", "accession_number", "acquired")
        VALUES
            ('Profusion of Flowers', '14.76', '1914-01-08'),
            ('Farmers Working at Dawn', '14.76', '1914-01-08'),
            ('Spring Outing', '14.76', '1914-01-08'),
            (Imaginative Landscape', '14.76', '1914-01-08');

## .import
    Let's you import a file like CSV and automatically insert it row by row into a table of you own making or one that you can let SQLite create for you.
    Importing into existing table:
        <> .import --csv --skip 1 mfa.csv collections
            .import --{csv file} --{skip row 1} {filename.csv} {table}
    
    Importing into brand new table:
        <> .import --csv mfa.csv temp
            Creates the table for you by reading the column heads from those in CSV and using them as you table columns

    Inserting into main table from temporary table
        <> INSERT INTO "collections" ("title", "accession_number", "acquired")
            SELECT "title", "accession_number", "acquired" FROM "temp";

            Inserts data from temporary table(temp) to our main table(collections) after that you can drop the temporary table. 

## Delete
    <> DELETE FROM {table} WHERE {condition};

    <> DELETE FROM "collections" WHERE "title" = 'Spring Outing';

    <> DELETE FROM "collections" WHERE "acquired" IS NULL;

    <> DELETE FROM "collections" WHERE "acquired" < '1909-01-01';

## Forein Key Constraints
### Constraint: FOREIGN KEY("artist_id") REFERENCES "artists"("id")
    The artist_id in created table is referencing the artist id in artist table.

    <STEP 1> DELETE FROM "created" WHERE "artist_id" = (
            SELECT "id" FROM  "artists" WHERE "name" = 'Unidentified artist'
        );

    <STEP 2> DELETE FROM "artist" WHERE "name" = 'Unidentified Artist';

### Better Constraint: FOREIGN KEY("artist_id") REFRENCES "artist"("id") ON DELETE CASCADE

## Update
    <> UPDATE {table} SET {column0 = value0} WHERE {condition};

    <> UPDATE "created" SET "artist_id" = (
            SELECT "id" FROM "artists" WHERE "name" = 'Li Yin'
        )
            WHERE "collection_id" = (
                SELECT "id" FROM "collections" WHERE "title" = 'Farmers Working at Dawn'
        );
    
    <> UPDATE "votes" SET "title" = trim("title");  trim capitalize the first letter

    <> UPDATE "votes" SET "title" = upper("title");  upper capitalize all letters

    <> UPDATE "votes" SET "title" = lower("title");  lower minimize all letters

    <> UPDATE "votes" SET "title" = 'FARMERS WORKING AT DAWN'
        WHERE "title" LIKE 'Fa%';

    <> UPDATE "collections" SET "deleted" = 1 WHERE "title" = 'Farmer's Working at Dawn';

## Triggers
    <> CREATE TRIGGER {name} BEFORE INSERT ON table 
    <> CREATE TRIGGER {name} BEFORE UPDATE OF column ON TABLE
    <> CREATE TRIGGER {name} BEFORE DELETE ON table FOR EACH ROW BEGIN ...; END;

    <> CREATE TRIGGER "sell"
        BEFORE DELETE ON "collections"
        FOR EACH ROW
        BEGIN
            INSERT INTO "transactions" ("title", "action")
            VALUES (OLD."title", 'sold');
        END;

    <> CREATE TRIGGER "buy"
        AFTER INSERT ON "collections"
        FOR EACH ROW 
        BEGIN
            INSERT INTO "transactions" ("title", "action")
            VALUES (NEW."title", 'bought');
        END;