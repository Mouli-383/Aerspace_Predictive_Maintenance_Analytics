WITH sensor_data AS (

    SELECT *

    FROM {{ ref('int_engine_sensor_trends') }}

),


engine_baseline AS (

    SELECT

        data_source,
        engine_id,

        AVG(sensor_2) AS baseline_sensor_2,

        AVG(sensor_3) AS baseline_sensor_3,

        AVG(sensor_4) AS baseline_sensor_4,

        AVG(sensor_7) AS baseline_sensor_7,

        AVG(sensor_8) AS baseline_sensor_8,

        AVG(sensor_9) AS baseline_sensor_9,

        AVG(sensor_11) AS baseline_sensor_11,

        AVG(sensor_12) AS baseline_sensor_12,

        AVG(sensor_13) AS baseline_sensor_13,

        AVG(sensor_14) AS baseline_sensor_14,

        AVG(sensor_15) AS baseline_sensor_15,

        AVG(sensor_17) AS baseline_sensor_17,

        AVG(sensor_20) AS baseline_sensor_20,

        AVG(sensor_21) AS baseline_sensor_21

    FROM sensor_data

    WHERE lifecycle_percentage <= 10

    GROUP BY

        data_source,
        engine_id

),


sensor_deviation AS (

    SELECT

        s.*,

        ABS(s.sensor_2 - b.baseline_sensor_2)
        / NULLIF(ABS(b.baseline_sensor_2), 0)
        AS sensor_2_deviation,


        ABS(s.sensor_3 - b.baseline_sensor_3)
        / NULLIF(ABS(b.baseline_sensor_3), 0)
        AS sensor_3_deviation,


        ABS(s.sensor_4 - b.baseline_sensor_4)
        / NULLIF(ABS(b.baseline_sensor_4), 0)
        AS sensor_4_deviation,


        ABS(s.sensor_7 - b.baseline_sensor_7)
        / NULLIF(ABS(b.baseline_sensor_7), 0)
        AS sensor_7_deviation,


        ABS(s.sensor_8 - b.baseline_sensor_8)
        / NULLIF(ABS(b.baseline_sensor_8), 0)
        AS sensor_8_deviation,


        ABS(s.sensor_9 - b.baseline_sensor_9)
        / NULLIF(ABS(b.baseline_sensor_9), 0)
        AS sensor_9_deviation,


        ABS(s.sensor_11 - b.baseline_sensor_11)
        / NULLIF(ABS(b.baseline_sensor_11), 0)
        AS sensor_11_deviation,


        ABS(s.sensor_12 - b.baseline_sensor_12)
        / NULLIF(ABS(b.baseline_sensor_12), 0)
        AS sensor_12_deviation,


        ABS(s.sensor_13 - b.baseline_sensor_13)
        / NULLIF(ABS(b.baseline_sensor_13), 0)
        AS sensor_13_deviation,


        ABS(s.sensor_14 - b.baseline_sensor_14)
        / NULLIF(ABS(b.baseline_sensor_14), 0)
        AS sensor_14_deviation,


        ABS(s.sensor_15 - b.baseline_sensor_15)
        / NULLIF(ABS(b.baseline_sensor_15), 0)
        AS sensor_15_deviation,


        ABS(s.sensor_17 - b.baseline_sensor_17)
        / NULLIF(ABS(b.baseline_sensor_17), 0)
        AS sensor_17_deviation,


        ABS(s.sensor_20 - b.baseline_sensor_20)
        / NULLIF(ABS(b.baseline_sensor_20), 0)
        AS sensor_20_deviation,


        ABS(s.sensor_21 - b.baseline_sensor_21)
        / NULLIF(ABS(b.baseline_sensor_21), 0)
        AS sensor_21_deviation

    FROM sensor_data s

    JOIN engine_baseline b

        ON s.engine_id = b.engine_id

        AND s.data_source = b.data_source

),


degradation_metrics AS (

    SELECT

        *,

        ROUND(

            (
                sensor_2_deviation +
                sensor_3_deviation +
                sensor_4_deviation +
                sensor_7_deviation +
                sensor_8_deviation +
                sensor_9_deviation +
                sensor_11_deviation +
                sensor_12_deviation +
                sensor_13_deviation +
                sensor_14_deviation +
                sensor_15_deviation +
                sensor_17_deviation +
                sensor_20_deviation +
                sensor_21_deviation
            ) / 14,

            4

        ) AS average_sensor_deviation

    FROM sensor_deviation

)


SELECT *

FROM degradation_metrics