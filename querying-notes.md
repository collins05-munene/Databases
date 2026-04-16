## Opening the db
    <> sqlite3 longlist.db

## What data is in our database
    ### SELECT KEYWORD
        <> SELECT * FROM "books";
            SELECT {all} FROM {table books};

        <> SELECT 'title' FROM "books";
            SELECT {column title(s)} FROM {table books};

        <> SELECT 'title', 'author' FROM "books";

    ### LIMIT KEYWORD
    