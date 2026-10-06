USE AerospacePredictiveMaintenanceDB;
GO

BULK INSERT cmaps.TrainData
FROM 'C:\Users\ACIAGO\Desktop\Aerospace_Predictive_Maintenance_Analytics\data\processed\FD001\train_FD001_processed.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

GO


SELECT COUNT(*) AS total_train_rows
FROM cmaps.TrainData;

SELECT TOP 10 *
FROM cmaps.TrainData;


BULK INSERT cmaps.TestData
FROM 'C:\Users\ACIAGO\Desktop\Aerospace_Predictive_Maintenance_Analytics\data\processed\FD001\test_FD001_processed.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

GO

SELECT COUNT(*) AS total_test_rows
FROM cmaps.TestData;


SELECT TOP 10 *
FROM cmaps.TestData;


BULK INSERT cmaps.RULData
FROM 'C:\Users\ACIAGO\Desktop\Aerospace_Predictive_Maintenance_Analytics\data\processed\FD001\RUL_FD001_processed.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

GO

SELECT COUNT(*) AS total_rul_rows
FROM cmaps.RULData;


SELECT TOP 10 *
FROM cmaps.RULData;


SELECT
    'TrainData' AS table_name,
    COUNT(*) AS total_rows
FROM cmaps.TrainData

UNION ALL

SELECT
    'TestData' AS table_name,
    COUNT(*) AS total_rows
FROM cmaps.TestData

UNION ALL

SELECT
    'RULData' AS table_name,
    COUNT(*) AS total_rows
FROM cmaps.RULData;