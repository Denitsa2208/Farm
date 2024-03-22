CREATE TABLE [dbo].[Animals]
(
	[Id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    [animal_type] VARCHAR NULL, 
    [production] VARCHAR NULL, 
    [animals_number] INT NULL
)
CREATE TABLE [dbo].[cows]
(
	[cow_id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    [date_added] DATE NULL, 
    [number] INT NULL, 
    [milk_production ] FLOAT NULL, 
    [production_date] DATE NULL,
    FOREIGN KEY (cow_id) REFERENCES Animals(Id)
)
CREATE TABLE [dbo].[goats]
(
	[goat_id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    [date_added] DATE NULL, 
    [number] INT NULL, 
    [milk_production] FLOAT NULL,
    [production_date] DATE NULL, 
    FOREIGN KEY (goat_id) REFERENCES Animals(Id)
    

)
CREATE TABLE [dbo].[chickens]
(
	[chicken_id] INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    [date_added] DATE NULL,  
    [eggs_production] FLOAT NULL, 
    [production_date] DATE NULL,
    FOREIGN KEY (chicken_id) REFERENCES Animals(Id)
)
CREATE TABLE [dbo].[sheep]
(
	[sheep_id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    [date_added] DATE NULL, 
    [number] INT NULL, 
    [wool_production] FLOAT NULL, 
    [production_date] DATE NULL,
    FOREIGN KEY (sheep_id) REFERENCES Animals(Id)
)
CREATE TABLE [dbo].[Products]
(
	[product] VARCHAR(50) NOT NULL PRIMARY KEY, 
    [quantity] FLOAT NULL
)
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
FROM (
    SELECT milk_production FROM cows
    UNION ALL
    SELECT milk_production FROM goats
) AS all_milk_production;
INSERT INTO Products (product, quantity)
VALUES ('milk', @totalMilkProduction);
SELECT *
FROM ProductionSummary
WHERE product = 'milk';

--TOTAL WOOL--
DECLARE @totalWoolProduction FLOAT;
SELECT @totalWoolProduction = SUM(wool_production)
FROM (
    SELECT wool_production FROM sheep
) AS all_wool_production;
INSERT INTO Products (product, quantity)
VALUES ('wool', @totalWoolProduction);
SELECT *
FROM ProductionSummary
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
FROM ProductionSummary
WHERE product = 'eggs';

--TOTAL PRODUCTION FOR THE LAST TWO WEEKS--
CREATE TABLE ProductionSummary (
    product VARCHAR(50),
    total_production FLOAT
);
DECLARE @totalMilkCows FLOAT;
SELECT @totalMilkCows = SUM(milk_production)
FROM cows
WHERE production_date >= DATEADD(WEEK, -2, GETDATE());
DECLARE @totalMilkGoats FLOAT;
SELECT @totalMilkGoats = SUM(milk_production)
FROM goats
WHERE production_date >= DATEADD(WEEK, -2, GETDATE());

INSERT INTO ProductionSummary (product, total_production)
VALUES ('milk', @totalMilkCows + @totalMilkGoats);

INSERT INTO ProductionSummary (product, total_production)
SELECT 'wool' AS product, SUM(wool_production) AS total_production
FROM sheep
WHERE production_date >= DATEADD(WEEK, -2, GETDATE());

INSERT INTO ProductionSummary (product, total_production)
SELECT 'eggs' AS product, SUM(eggs_production) AS total_production
FROM chickens
WHERE production_date >= DATEADD(WEEK, -2, GETDATE());
SELECT * FROM [ProductionSummary];

--TOTAL AMOUNT ANIMALS--
CREATE TABLE [TotalAnimals]
(
  animal_type VARCHAR(50),
  total_number INT
);
INSERT INTO [TotalAnimals] (animal_type, total_number)
SELECT 'cows', COUNT(*)
FROM cows;

INSERT INTO [TotalAnimals] (animal_type, total_number)
SELECT 'goats', COUNT(*)
FROM goats;

INSERT INTO [TotalAnimals] (animal_type, total_number)
SELECT 'chickens', COUNT(*)
FROM chickens;

INSERT INTO [TotalAnimals] (animal_type, total_number)
SELECT 'sheep', COUNT(*)
FROM sheep;







