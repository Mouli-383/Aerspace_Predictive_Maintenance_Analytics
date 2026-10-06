USE AerospacePredictiveMaintenanceDB;
GO


-- =========================================
-- 1. VIEW SAMPLE TRAINING DATA
-- =========================================

SELECT TOP 10 *
FROM cmaps.TrainData;


-- =========================================
-- 2. NUMBER OF CYCLES FOR EACH ENGINE
-- =========================================

SELECT
    engine_id,
    MAX(cycle) AS total_cycles
FROM cmaps.TrainData
GROUP BY engine_id
ORDER BY engine_id;


-- =========================================
-- 3. LONGEST RUNNING ENGINES
-- =========================================

SELECT TOP 10
    engine_id,
    MAX(cycle) AS total_cycles
FROM cmaps.TrainData
GROUP BY engine_id
ORDER BY total_cycles DESC;


-- =========================================
-- 4. SHORTEST RUNNING ENGINES
-- =========================================

SELECT TOP 10
    engine_id,
    MAX(cycle) AS total_cycles
FROM cmaps.TrainData
GROUP BY engine_id
ORDER BY total_cycles ASC;


-- =========================================
-- 5. SIMPLE SENSOR STATISTICS
-- =========================================

SELECT
    AVG(sensor_1) AS avg_sensor_1,
    MIN(sensor_1) AS min_sensor_1,
    MAX(sensor_1) AS max_sensor_1,

    AVG(sensor_2) AS avg_sensor_2,
    MIN(sensor_2) AS min_sensor_2,
    MAX(sensor_2) AS max_sensor_2

FROM cmaps.TrainData;


-- =========================================
-- 6. CHECK RUL DATA
-- =========================================

SELECT TOP 10 *
FROM cmaps.RULData;


-- =========================================
-- 7. RUL SUMMARY
-- =========================================

SELECT
    MIN(remaining_useful_life) AS minimum_rul,
    MAX(remaining_useful_life) AS maximum_rul,
    AVG(remaining_useful_life) AS average_rul
FROM cmaps.RULData;

GO