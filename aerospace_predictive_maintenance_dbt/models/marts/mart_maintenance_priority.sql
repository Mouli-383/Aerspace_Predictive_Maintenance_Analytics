WITH current_engine_health AS (

    SELECT *

    FROM {{ ref('mart_engine_current_health') }}

),


rul_data AS (

    SELECT

        engine_id,

        remaining_useful_life

    FROM {{ ref('stg_rul_data') }}

),


engine_maintenance_data AS (

    SELECT

        e.data_source,

        e.engine_id,

        e.latest_cycle,

        e.lifecycle_percentage,

        e.average_sensor_deviation,

        e.degradation_score,

        e.engine_health_score,

        e.risk_level,


        CASE

            WHEN e.data_source = 'TEST'

            THEN r.remaining_useful_life

            ELSE NULL

        END AS remaining_useful_life


    FROM current_engine_health e

    LEFT JOIN rul_data r

        ON e.engine_id = r.engine_id

        AND e.data_source = 'TEST'

)


SELECT

    *,

    CASE


        /* =========================================
           RULE 1: CRITICAL ENGINE CONDITION
           ========================================= */

        WHEN risk_level = 'CRITICAL'

        THEN 'IMMEDIATE'


        /* =========================================
           RULE 2: VERY LOW RUL + POOR HEALTH
           ========================================= */

        WHEN remaining_useful_life <= 20
             AND engine_health_score < 40

        THEN 'IMMEDIATE'


        /* =========================================
           RULE 3: VERY LOW RUL + MODERATE HEALTH
           ========================================= */

        WHEN remaining_useful_life <= 20
             AND engine_health_score >= 40
             AND engine_health_score < 70

        THEN 'URGENT'


        /* =========================================
           RULE 4: VERY LOW RUL + GOOD HEALTH
           ========================================= */

        WHEN remaining_useful_life <= 20
             AND engine_health_score >= 70

        THEN 'PRIORITY INSPECTION'


        /* =========================================
           RULE 5: LOW TO MODERATE RUL + POOR HEALTH
           ========================================= */

        WHEN remaining_useful_life > 20
             AND remaining_useful_life <= 50
             AND engine_health_score < 50

        THEN 'URGENT'


        /* =========================================
           RULE 6: LOW TO MODERATE RUL + ACCEPTABLE HEALTH
           ========================================= */

        WHEN remaining_useful_life > 20
             AND remaining_useful_life <= 50
             AND engine_health_score >= 50

        THEN 'SCHEDULED'


        /* =========================================
           RULE 7: HIGH RISK WITHOUT LOW RUL
           ========================================= */

        WHEN risk_level = 'HIGH'

        THEN 'HIGH'


        /* =========================================
           RULE 8: MEDIUM RISK
           ========================================= */

        WHEN risk_level = 'MEDIUM'

        THEN 'SCHEDULED'


        /* =========================================
           RULE 9: LOW RISK / HEALTHY CONDITION
           ========================================= */

        ELSE 'ROUTINE'

    END AS maintenance_priority


FROM engine_maintenance_data