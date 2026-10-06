SELECT

    data_source,

    COUNT(*) AS total_engines,

    ROUND(
        AVG(engine_health_score),
        2
    ) AS average_fleet_health_score,


    SUM(

        CASE

            WHEN risk_level = 'CRITICAL'

            THEN 1

            ELSE 0

        END

    ) AS critical_engine_count,


    SUM(

        CASE

            WHEN risk_level = 'HIGH'

            THEN 1

            ELSE 0

        END

    ) AS high_risk_engine_count,


    SUM(

        CASE

            WHEN risk_level = 'MEDIUM'

            THEN 1

            ELSE 0

        END

    ) AS medium_risk_engine_count,


    SUM(

        CASE

            WHEN risk_level = 'LOW'

            THEN 1

            ELSE 0

        END

    ) AS low_risk_engine_count,


    ROUND(

        (
            SUM(

                CASE

                    WHEN risk_level = 'LOW'

                    THEN 1

                    ELSE 0

                END

            ) * 100.0

        ) / COUNT(*),

        2

    ) AS fleet_health_percentage


FROM {{ ref('mart_engine_current_health') }}

GROUP BY data_source