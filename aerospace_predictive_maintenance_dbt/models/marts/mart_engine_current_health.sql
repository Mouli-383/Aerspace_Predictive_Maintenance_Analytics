WITH ranked_engine_data AS (

    SELECT

        *,

        ROW_NUMBER() OVER (

            PARTITION BY
                data_source,
                engine_id

            ORDER BY cycle DESC

        ) AS row_number

    FROM {{ ref('int_engine_health_scores') }}

)


SELECT

    data_source,

    engine_id,

    cycle AS latest_cycle,

    maximum_cycle,

    lifecycle_percentage,

    average_sensor_deviation,

    degradation_score,

    engine_health_score,

    risk_level

FROM ranked_engine_data

WHERE row_number = 1