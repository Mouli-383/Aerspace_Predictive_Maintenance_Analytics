SELECT

    data_source,
    engine_id,
    cycle,
    engine_health_score

FROM {{ ref('int_engine_health_scores') }}

WHERE engine_health_score < 0
   OR engine_health_score > 100