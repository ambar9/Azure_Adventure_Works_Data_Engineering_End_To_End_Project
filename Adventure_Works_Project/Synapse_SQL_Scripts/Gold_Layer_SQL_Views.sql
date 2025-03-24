-- Creating view for AdventureWorks_Calendar

CREATE VIEW gold.calendar AS
    SELECT
        *
    FROM
        OPENROWSET(
            BULK 'https://datalakeambars.dfs.core.windows.net/silver/AdventureWorks_Calendar/',
            FORMAT = 'PARQUET'
        ) AS query1;



-- Creating view for AdventureWorks_Customer

CREATE VIEW gold.customers AS
    SELECT
        *
    FROM
        OPENROWSET(
            BULK 'https://datalakeambars.dfs.core.windows.net/silver/AdventureWorks_Customer/',
            FORMAT = 'PARQUET'
        ) AS query2;



-- Creating view for AdventureWorks_Product_Categories

CREATE VIEW gold.Product_Categories AS
    SELECT
        *
    FROM
        OPENROWSET(
            BULK 'https://datalakeambars.dfs.core.windows.net/silver/AdventureWorks_Product_Categories/',
            FORMAT = 'PARQUET'
        ) AS query3;



-- Creating view for AdventureWorks_Product_Subcategory

CREATE VIEW gold.Product_Subcategory AS
    SELECT
        *
    FROM
        OPENROWSET(
            BULK 'https://datalakeambars.dfs.core.windows.net/silver/AdventureWorks_Product_Subcategory/',
            FORMAT = 'PARQUET'
        ) AS query4;



-- Creating view for Products

CREATE VIEW gold.Products AS
    SELECT
        *
    FROM
        OPENROWSET(
            BULK 'https://datalakeambars.dfs.core.windows.net/silver/AdventureWorks_Products/',
            FORMAT = 'PARQUET'
        ) AS query5;


-- Creating view for AdventureWorks_Returns

CREATE VIEW gold.returns AS
    SELECT
        *
    FROM
        OPENROWSET(
            BULK 'https://datalakeambars.dfs.core.windows.net/silver/AdventureWorks_Returns/',
            FORMAT = 'PARQUET'
        ) AS query6;



-- Creating view for AdventureWorks_Sales

CREATE VIEW gold.sales AS
    SELECT
        *
    FROM
        OPENROWSET(
            BULK 'https://datalakeambars.dfs.core.windows.net/silver/AdventureWorks_Sales/',
            FORMAT = 'PARQUET'
        ) AS query7;



-- Creating view for AdventureWorks_Territories

CREATE VIEW gold.territories AS
    SELECT
        *
    FROM
        OPENROWSET(
            BULK 'https://datalakeambars.dfs.core.windows.net/silver/AdventureWorks_Territories/',
            FORMAT = 'PARQUET'
        ) AS query8;