USE AerospacePredictiveMaintenanceDB;
GO


-- =========================================
-- 1. CHECK TRAIN DATA ROW COUNT
-- =========================================

SELECT COUNT(*) AS train_data_rows
FROM cmaps.TrainData;


-- =========================================
-- 2. CHECK TEST DATA ROW COUNT
-- =========================================

SELECT COUNT(*) AS test_data_rows
FROM cmaps.TestData;


-- =========================================
-- 3. CHECK RUL DATA ROW COUNT
-- =========================================

SELECT COUNT(*) AS rul_data_rows
FROM cmaps.RULData;


-- =========================================
-- 4. CHECK NUMBER OF TRAIN ENGINES
-- =========================================

SELECT COUNT(DISTINCT engine_id) AS train_engines
FROM cmaps.TrainData;


-- =========================================
-- 5. CHECK NUMBER OF TEST ENGINES
-- =========================================

SELECT COUNT(DISTINCT engine_id) AS test_engines
FROM cmaps.TestData;


-- =========================================
-- 6. CHECK FOR DUPLICATE ENGINE + CYCLE
-- =========================================

SELECT
    engine_id,
    cycle,
    COUNT(*) AS duplicate_count
FROM cmaps.TrainData
GROUP BY
    engine_id,
    cycle
HAVING COUNT(*) > 1;


-- =========================================
-- 7. CHECK FOR NULL ENGINE IDs
-- =========================================

SELECT COUNT(*) AS null_engine_ids
FROM cmaps.TrainData
WHERE engine_id IS NULL;


-- =========================================
-- 8. CHECK FOR NULL CYCLES
-- =========================================

SELECT COUNT(*) AS null_cycles
FROM cmaps.TrainData
WHERE cycle IS NULL;