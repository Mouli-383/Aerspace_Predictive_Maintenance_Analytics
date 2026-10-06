SELECT

    engine_id,

    remaining_useful_life,

    dataset_id,

    processed_at

FROM {{ source('raw', 'rul_data') }}