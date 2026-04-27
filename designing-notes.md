# DESIGNING

## .schema
    <> .schema
        . Command used to check the command that created a certain table.
        It returns:
            CREATE TABLE IF NOT EXISTS "longlist" (
                "isbn" TEXT,
                "title" TEXT,
                "author" TEXT,
                "transaltor" TEXT,
                "format" TEXT,
                "pages" INTEGER,
                "publisher" TEXT,
                "published" TEXT,
                "year" INTEGER,
                "votes" INTEGER,
                "rating" REAL
            );

    <> .schema {table_name}

## Normalizing
    To reduce redundanacies effectively; To take one table for instance, split up into multiple table and have each entity be part of its very own table.

## CREATE TABLE
    CREATE TABLE "riders: (
        'id',
        'name'
    );

    CREATE TABLE "stations: (
        'id',
        'name',
        'line'
    );

    Relating Them by creating a Junction/ Joining Table:
        CREATE TABLE "visits" (
            'rider_id',
            'station_id',
        );

## Data Types & Storage Classes
 ### SQLite has 5 storage classes:
    > NULL
    > INTEGER
        0-byte integer
        1-byte integer
        2-byte integer
        3-byte integer
        4-byte integer
    > REAL
        Floating Point Number
    > TEXT
    > BLOB 
        Binary Large Object, 101110, used to rep files/ images.....

    SQLite has no booleans
 ### Type Affinities
    > TEXT
    > NUMERIC
    > INTEGER
    > REAL
    > BLOB

## DROP
    <> DROP TABLLE "riders";
        . Deleting command
        
## .SQL file
    Allows me to type in SQL keywords and have the, be syntax highlighted.
        <> code schema.sql
        <> .read schema.sql

## Table Constraints
    Constraints means some values a certain way.
        e.g Primary keys must be unique , They can't repeat, In our case they can be integers  . PRIMARY KEY("id")
            Foreign Key find it in some other tables.
    
    CREATE TABLE "visits" (
        "id" INTEGER,
        "rider_id" INTEGER,
        "station_id" INTEGER,
        PRIMARY KEY("id"),
        FOREIGN KEY("rider_id") REFERENCES "riders"("id"),
        FOREIGN KEY("station_id") REFERENCES "stations"("id"),
    );

## Column Constraints
    Applies to a particular column
        > CHECK
            . check to be sure this amount > 0
        > DEFAULT
            . don't supply a value, use default
        > NOT NULL
            . I can't insert null values
        > UNIQUE
            . every row in this column is unique

    CREATE TABLE "stations" (
        "id" INTEGER,
        "name" TEXT NOT NULL UNIQUE,
        "line" TEXT NOT NULL,
        PRIMARY KEY("id")
    );

## Altering Tables
 ### Drop Table
    <> DROP TABLE "riders";

 ### Alter Table
    <> ALTER TABLE "visits" RENAME TO "swipes";

    <> ALTER TABLE "swipes" ADD COLUMN "ttpe" TEXT;

    <> ALTER TABLE "swipes" RENAME COLUMN "ttpe" TO "type";

    <> ALTER TABLE "swipes" DROP COLUMN "type";

    <> ALTER TABLE "collections" ADD COLUMN "deleted" INTEGER DEFAULT 0;