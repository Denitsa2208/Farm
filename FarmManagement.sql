USE farm;

CREATE TABLE [dbo].[Animals]
(
	[Id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    [animal_type] VARCHAR(50) NULL, 
    [production] VARCHAR NULL, 
    [animals_number] INT NULL
)

CREATE TABLE [dbo].[cows]
(
	[cow_id] INT NOT NULL PRIMARY KEY, 
    [date_added] DATE NULL, 
    [number] INT NULL, 
    [milk_production ] FLOAT NULL, 
    [production_date] DATE NULL,
    FOREIGN KEY (cow_id) REFERENCES Animals(Id)
	ON DELETE CASCADE
)
CREATE TABLE [dbo].[goats]
(
	[goat_id] INT NOT NULL PRIMARY KEY, 
    [date_added] DATE NULL, 
    [number] INT NULL, 
    [milk_production] FLOAT NULL,
    [production_date] DATE NULL, 
    FOREIGN KEY (goat_id) REFERENCES Animals(Id)
	ON DELETE CASCADE
)
CREATE TABLE [dbo].[chickens]
(
	[chicken_id] INT NOT NULL PRIMARY KEY, 
    [date_added] DATE NULL,  
    [eggs_production] FLOAT NULL, 
    [production_date] DATE NULL,
    FOREIGN KEY (chicken_id) REFERENCES Animals(Id)
	ON DELETE CASCADE
)
CREATE TABLE [dbo].[sheep]
(
	[sheep_id] INT NOT NULL PRIMARY KEY, 
    [date_added] DATE NULL, 
    [number] INT NULL, 
    [wool_production] FLOAT NULL, 
    [production_date] DATE NULL,
    FOREIGN KEY (sheep_id) REFERENCES Animals(Id)
	ON DELETE CASCADE
)
CREATE TABLE [dbo].[Products]
(
    [No] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[product] VARCHAR(50) NOT NULL, 
    [quantity] FLOAT NULL
)
SELECT * FROM Products;

INSERT INTO [dbo].[cows] (cow_id)
SELECT [Id] FROM [dbo].[Animals]
WHERE [animal_type]='cow';
INSERT INTO [dbo].[goats] (goat_id)
SELECT [Id] FROM [dbo].[Animals]
WHERE [animal_type]='goat';
INSERT INTO [dbo].[chickens] (chicken_id)
SELECT [Id] FROM [dbo].[Animals]
WHERE [animal_type]='chicken';
INSERT INTO [dbo].[sheep] (sheep_id)
SELECT [Id] FROM [dbo].[Animals]
WHERE [animal_type]='sheep';

--TOTAL MILK--
DECLARE @totalMilkProduction FLOAT;
SELECT @totalMilkProduction = SUM(milk_production)
FROM cows;

DECLARE @totalGoatMilkProduction FLOAT;
SELECT @totalGoatMilkProduction = SUM(milk_production)
FROM goats;

INSERT INTO Products (product, quantity)
SELECT 'milk_cow' AS product, SUM(milk_production) AS quantity
FROM cows

INSERT INTO Products (product, quantity)
SELECT 'milk_goat' AS product, SUM(milk_production) AS quantity
FROM cows

--TOTAL WOOL--
DECLARE @totalWoolProduction FLOAT;
SELECT @totalWoolProduction = SUM(wool_production)
FROM (
    SELECT wool_production FROM sheep
) AS all_wool_production;
INSERT INTO Products (product, quantity)
VALUES ('wool', @totalWoolProduction);
SELECT *
FROM Products
WHERE product = 'wool';

--TOTAL EGGS--
DECLARE @totalEggsProduction FLOAT;
SELECT @totalEggsProduction = SUM(eggs_production)
FROM (
    SELECT eggs_production FROM chickens
) AS all_eggs_production;
INSERT INTO Products (product, quantity)
VALUES ('eggs', @totalEggsProduction)
SELECT *
FROM Products
WHERE product = 'eggs';

