WITH degradation_data AS (

    SELECT *

    FROM {{ ref('int_engine_degradation_metrics') }}

),


health_metrics AS (

    SELECT

        *,

        ROUND(
            (
                lifecycle_percentage * 0.50
            )
            +
            (
                average_sensor_deviation * 100 * 0.50
            ),
            2
        ) AS degradation_score

    FROM degradation_data

)


SELECT

    *,

    ROUND(
        100 - degradation_score,
        2
    ) AS engine_health_score,


    CASE

        WHEN degradation_score >= 75 THEN 'CRITICAL'

        WHEN degradation_score >= 50 THEN 'HIGH'

        WHEN degradation_score >= 25 THEN 'MEDIUM'

        ELSE 'LOW'

    END AS risk_level

FROM health_metrics