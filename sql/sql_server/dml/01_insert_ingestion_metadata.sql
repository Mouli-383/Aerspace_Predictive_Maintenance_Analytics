USE AerospacePredictiveMaintenanceDB;
GO


CREATE TABLE cmaps.IngestionMetadata
(
    dataset_name VARCHAR(50),
    file_name VARCHAR(100),
    data_type VARCHAR(20),
    description VARCHAR(200)
);

GO

INSERT INTO cmaps.IngestionMetadata
VALUES
(
    'FD001',
    'train_FD001_processed.csv',
    'TRAIN',
    'Processed training data for FD001'
);


INSERT INTO cmaps.IngestionMetadata
VALUES
(
    'FD001',
    'test_FD001_processed.csv',
    'TEST',
    'Processed test data for FD001'
);


INSERT INTO cmaps.IngestionMetadata
VALUES
(
    'FD001',
    'RUL_FD001_processed.csv',
    'RUL',
    'Remaining Useful Life values for FD001'
);

GO


SELECT *
FROM cmaps.IngestionMetadata;

