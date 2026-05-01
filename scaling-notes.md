# Scaling
    Ability to increase or decrease capacity to meet demand.
    MySQL, PostgreSQL, ...

    <> mysql -u {user account} -h {ip address} -P {port} -p
    <> mysql -u root -h 127.0.0.1 -P 3306 -p

    <> SHOW DATABASES;

    <> CREATE DATABASE `mbta`;
    <> USE `mbta`

    <> SHOW TABLES;

    <> DESCRIBE `cards`;

## Types
### MySQL Data Types for integers:
    TINYINT -> 1 byte
    SMALLLINT -> 2 bytes
    MEDIUMINT -> 3 bytes
    INT -> 4 bytes
    BIGINT -> 8 bytes

    Unsigned Integer has no negative values
    In MySQL you add auto_increment for your primary keys

    SQLITE3 'cards' TABLE:
        <> CREATE TABLE "cards" (
            "id" INTEGER,
            PRIMARY KEY("id")
            );
        
    MYSQL 'cards' TABLE:
        <> CREATE TABLE `cards` (
            `id` INT AUTO_INCREMENT,
            PRIMARY KEY(`id`)
        )

### MySQL Data Types for Strings:
    CHAR(M) -> Holds only two characters
    VARCHAR(M) -> Accepts variable like some string upto some number
    TEXT -> Good for longer chunks of characers like paragraphs
        TINYTEXT
        TEXT
        MEDIUMTEXT
        LONGTEXT
    BLOB -> Binary
    ENUM -> eNUMERATE THE POSSIBLE OPTION i COULD USE FOR THIS COLUMN
    SET -> Choose more than one,

    SQLITE3 'stations' TABLE:
        <> CREATE TABLE "stations" (
            "id" INTEGER,
            "name" TEXT NOT NULL UNIQUE,
            "line" TEXT NOT NULL,
            PRIMARY KEY("id")
        );

    MYSQL 'stations" TABLE:
        <> CREATE TABLE `stations` (
            `id` INT AUTO_INCREMENT,
            `name` VARCHAR(32) NOT NULL,
            `line` ENUM(`blue`, ...) NOT NULL,
            PRIMARY KEY(`id`)
        );
### Date & Times
    DATE
    TIME(fsp)
    DATETIME(fsp)
    TIMESTAMP(fsp)
    YEAR

### Real Numbers
    FLOAT -> 4 bytes
    DOUBLE PRECISION -> 8 bytes

    SQLITE 'swipes' TABLE:
        <> CREATE TABLE "swipes" (
            "type" TEXT NOT NULL CHECK("type" IN ('enter', ...)),
            "datetime" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
            "amount" NUMERIC NOT NULL CHECK("amount" != 0),
            ...
        );

    MYSQL "swipes" TABLE:
        <> CREATE TABLE `swipes` (
            `id` INT AUTO_INCREMENT,
            `card_id` INT,
            `station_id` INT,
            `type` ENUM ('enter', 'exit', 'deposit') NOT NULL,
            `datetime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
            `amount` DECIMAL(5,2) NOT NULL CHECK(`amount` != 0),
            PRIMARY KEY(`id`),
            FOREIGN KEY(`card_id`) REFERENCES `cards`(`id`),
            FOREIGN KEY(`station_id`) REFERENCES `stations`(`id`)
        );

CREATE TABLE `swipes` (
      `id` INT AUTO_INCREMENT,
      `card_id` INT,
      `station_id` INT,
      `type` ENUM('enter', 'exit', 'deposit') NOT NULL,
      `datetime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
      `amount` DECIMAL(5,2) NOT NULL CHECK (`amount` != 0),
      PRIMARY KEY(`id`),
      FOREIGN KEY(`card_id`) REFERENCES `cards`(`id`),
      FOREIGN KEY(`station_id`) REFERENCES `stations`(`id`)
    );

## Altering Tables
    <> ALTER TABLE ...;
    <> MODIFY ABLE ...;

    <> ALTER TABLE `stations`
        MODIFY `line` ENUM('blue', 'green', 'orange', 'red', 'silver') NOT NULL;
    
    <> ALTER TABLE `collections`
        ADD COLUMN ` deleted` TINYINT DEFAULT 0;

## Stored Procedures
    . A way to automate the running of sql statement over and over again. Useful when scaling.
    . Compatible with
        IF, ELSEIF, ELSE
        LOOP
        REPEAT
        WHILE
        ...

    SYNTAX:
        <> CREATE PROCEDURE name
            BEGIN
                ...
            END;
### Changing delimiter
    <> delimiter //

### Creating Procedure
    <> CREATE PROCEDURE `current_collection`()
        BEGIN
        SELECT `title`, `accession_Number`, `acquired`
        FROM `collections` WHERE `deleted` = 0;
        END //

    <> CREATE PROCEDURE `sell`(IN `sold_id` INT)
        BEGIN
        UPDATE `collections` SET `deleted` = 1 
        WHERE `id` = `sold_id`;
        INSERT INTO `transactions` (`title`, `action`)
        VALUES ((SELECT `title` FROM `collections` WHERE `id` = `sold_id`), 'sold');
        END//

    <> delimiter ;

### Call Procedure
    <> CALL `current_collections`();
    
    <> CALL `sell`(2);

