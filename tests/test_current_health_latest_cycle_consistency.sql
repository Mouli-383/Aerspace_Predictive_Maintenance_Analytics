SELECT

    data_source,
    engine_id,
    latest_cycle,
    maximum_cycle

FROM {{ ref('mart_engine_current_health') }}

WHERE latest_cycle <> maximum_cycle