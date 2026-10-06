SELECT

    data_source,
    engine_id,
    cycle,
    COUNT(*) AS record_count

FROM {{ ref('mart_engine_health_history') }}

GROUP BY

    data_source,
    engine_id,
    cycle

HAVING COUNT(*) > 1