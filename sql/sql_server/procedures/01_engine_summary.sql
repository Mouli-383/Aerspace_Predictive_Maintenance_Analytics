USE AerospacePredictiveMaintenanceDB;
GO


CREATE PROCEDURE cmaps.GetEngineSummary
    @engine_id INT
AS
BEGIN

    SELECT
        engine_id,
        MAX(cycle) AS maximum_cycle,
        AVG(sensor_1) AS average_sensor_1,
        AVG(sensor_2) AS average_sensor_2,
        AVG(sensor_3) AS average_sensor_3

    FROM cmaps.TrainData

    WHERE engine_id = @engine_id

    GROUP BY engine_id;

END;

GO


EXEC cmaps.GetEngineSummary @engine_id = 1;