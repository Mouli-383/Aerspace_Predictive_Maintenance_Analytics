SELECT

    data_source,
    engine_id,
    cycle,
    maximum_cycle

FROM {{ ref('int_engine_sensor_trends') }}

WHERE cycle > maximum_cycle