SELECT

    data_source,
    engine_id,
    COUNT(*) AS record_count

FROM {{ ref('mart_engine_current_health') }}

GROUP BY

    data_source,
    engine_id

HAVING COUNT(*) > 1