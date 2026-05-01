# Scaling

## Logging in to PostgreSQL
    <> psql postgresql://postgres@127.0.0.1:5432/postgres

## List all databases
    <> \l

## Create database
    <> CREATE DATABASE "mbta";

## Connect to a database
    <> \c "mbta"

## List tables
    <> \dt

## Create table
    <> CREATE TABLE "cards" (
        "id" SERIAL,
        PRIMARY KEY("id")
    );

## Access table details
    <> \d "cards"

## Integer
    SMALLINT -> 2
    INT -> 4
    BIGINT -> 8

    SMALLSERIAL
    SERIAL -> has auto_increment
    BIGSERIAL

## Creating you own type
    <> CREATE TYPE "swipe_type"
       AS
       ENUM ('enter', 'exit', 'deposit');

## Dates & Time
    TIMESTAMP(p)
    DATE
    TIME(p)
    INTERVAL(p)

## Real Numbers
    MONEY -> for money
    NUMERIC(precision, scale) -> decimal

    CREATE TABLE "swipes" (
        ...,
        "type" "swipe_type" NOT NULL,
        "datetime" TIMESTAMP NOT NULL DEFAULT now(),
        "amount" NUMERIC(5,2) NOT NULL CHECK("amount" != 0),
        ...
    );

## Quitting
    <> \q