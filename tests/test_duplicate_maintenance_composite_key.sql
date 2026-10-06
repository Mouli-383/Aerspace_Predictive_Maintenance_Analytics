SELECT

    data_source,
    engine_id,
    COUNT(*) AS record_count

FROM {{ ref('mart_maintenance_priority') }}

GROUP BY

    data_source,
    engine_id

HAVING COUNT(*) > 1