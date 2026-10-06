SELECT

    data_source,
    engine_id,
    cycle,
    degradation_score

FROM {{ ref('int_engine_health_scores') }}

WHERE degradation_score < 0