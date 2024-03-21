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
    [date_added] DATE NOT NULL, 
    [number] INT NOT NULL, 
    [milk_production ] FLOAT NOT NULL, 
    [production_date] DATE NOT NULL,
    FOREIGN KEY (cow_id) REFERENCES Animals(Id)
)
CREATE TABLE [dbo].[goats]
(
	[goat_id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    [date_added] DATE NOT NULL, 
    [number] INT NOT NULL, 
    [milk_production] FLOAT NOT NULL,
    [production_date] DATE NOT NULL, 
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
CREATE TABLE [dbo].[chickens]
(
	[chicken_id] INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    [date_added] DATE NULL,  
    [eggs_production] FLOAT NULL, 
    [production_date] DATE NULL,
    FOREIGN KEY (chicken_id) REFERENCES Animals(Id)
)
CREATE TABLE [dbo].[Products]
(
	[product] VARCHAR(50) NOT NULL PRIMARY KEY, 
    [quantity] FLOAT NULL
)