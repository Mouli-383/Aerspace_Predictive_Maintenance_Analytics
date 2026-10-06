SELECT

    data_source,
    engine_id,
    cycle,
    maximum_cycle

FROM {{ ref('int_engine_sensor_trends') }}

WHERE maximum_cycle <= 0