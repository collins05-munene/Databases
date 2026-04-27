CREATE TABLE "collections" (
    "id" INTEGER,
    "title" TEXT NOT NULL,
    "accession_number" TEXT NOT NULL UNIQUE,
    "acquired" NUMERIC,
    PRIMARY KEY("id")
);

INSERT INTO "collections" ("id", "title", "accession_number", "acquired")
    VALUES (1, 'Profusion of Flowers', '56.257', '1956-04-12');