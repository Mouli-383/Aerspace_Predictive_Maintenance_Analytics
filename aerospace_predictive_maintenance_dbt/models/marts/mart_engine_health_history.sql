SELECT

    data_source,

    engine_id,

    cycle,

    maximum_cycle,

    lifecycle_percentage,

    average_sensor_deviation,

    degradation_score,

    engine_health_score,

    risk_level

FROM {{ ref('int_engine_health_scores') }}