SELECT

    data_source,
    engine_id,
    remaining_useful_life

FROM {{ ref('mart_maintenance_priority') }}

WHERE data_source = 'TEST'

  AND remaining_useful_life IS NULL