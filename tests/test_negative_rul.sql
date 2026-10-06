SELECT

    engine_id,
    remaining_useful_life

FROM {{ ref('stg_rul_data') }}

WHERE remaining_useful_life < 0