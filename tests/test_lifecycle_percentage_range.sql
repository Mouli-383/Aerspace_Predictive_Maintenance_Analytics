SELECT

    data_source,
    engine_id,
    cycle,
    lifecycle_percentage

FROM {{ ref('int_engine_sensor_trends') }}

WHERE lifecycle_percentage < 0
   OR lifecycle_percentage > 100