WITH engine_data AS (

    SELECT *

    FROM {{ ref('stg_engine_sensor_data') }}

),


engine_lifecycle AS (

    SELECT

        *,

        MAX(cycle) OVER (

            PARTITION BY
                data_source,
                engine_id

        ) AS maximum_cycle

    FROM engine_data

)


SELECT

    *,

    ROUND(

        (cycle * 100.0) / maximum_cycle,

        2

    ) AS lifecycle_percentage

FROM engine_lifecycle