USE AerospacePredictiveMaintenanceDB;
GO


-- ============================================
-- TABLE 1: TRAINING DATA
-- ============================================

CREATE TABLE cmaps.TrainData
(
    engine_id INT,
    cycle INT,

    operational_setting_1 FLOAT,
    operational_setting_2 FLOAT,
    operational_setting_3 FLOAT,

    sensor_1 FLOAT,
    sensor_2 FLOAT,
    sensor_3 FLOAT,
    sensor_4 FLOAT,
    sensor_5 FLOAT,
    sensor_6 FLOAT,
    sensor_7 FLOAT,
    sensor_8 FLOAT,
    sensor_9 FLOAT,
    sensor_10 FLOAT,
    sensor_11 FLOAT,
    sensor_12 FLOAT,
    sensor_13 FLOAT,
    sensor_14 FLOAT,
    sensor_15 FLOAT,
    sensor_16 FLOAT,
    sensor_17 FLOAT,
    sensor_18 FLOAT,
    sensor_19 FLOAT,
    sensor_20 FLOAT,
    sensor_21 FLOAT,

    dataset_name VARCHAR(20),
    data_type VARCHAR(20),
    processed_timestamp DATETIME
);


-- ============================================
-- TABLE 2: TEST DATA
-- ============================================

CREATE TABLE cmaps.TestData
(
    engine_id INT,
    cycle INT,

    operational_setting_1 FLOAT,
    operational_setting_2 FLOAT,
    operational_setting_3 FLOAT,

    sensor_1 FLOAT,
    sensor_2 FLOAT,
    sensor_3 FLOAT,
    sensor_4 FLOAT,
    sensor_5 FLOAT,
    sensor_6 FLOAT,
    sensor_7 FLOAT,
    sensor_8 FLOAT,
    sensor_9 FLOAT,
    sensor_10 FLOAT,
    sensor_11 FLOAT,
    sensor_12 FLOAT,
    sensor_13 FLOAT,
    sensor_14 FLOAT,
    sensor_15 FLOAT,
    sensor_16 FLOAT,
    sensor_17 FLOAT,
    sensor_18 FLOAT,
    sensor_19 FLOAT,
    sensor_20 FLOAT,
    sensor_21 FLOAT,

    dataset_name VARCHAR(20),
    data_type VARCHAR(20),
    processed_timestamp DATETIME
);


-- ============================================
-- TABLE 3: RUL DATA
-- ============================================

CREATE TABLE cmaps.RULData
(
    engine_id INT,
    remaining_useful_life INT,

    dataset_name VARCHAR(20),
    processed_timestamp DATETIME
);

GO