CREATE TABLE bottlenecks AS
    WITH
        nj AS (
            SELECT
                rank,
				head_location,
				average_max_length,
				average_daily_duration,
				total_duration,
				all_events_incidents,
				volume_estimate,
				base_impact,
				speed_differential,
				congestion,
                ST_SETSRID(
                    ST_POINT(longitude, latitude),
                    4326
                ) AS geom
            FROM nj_bottlenecks
        ),
        pa AS (
            SELECT
                rank,
				head_location,
				average_max_length,
				average_daily_duration,
				total_duration,
				all_events_incidents,
				volume_estimate,
				base_impact,
				speed_differential,
				congestion,
                ST_SETSRID(
                    ST_POINT(longitude, latitude),
                    4326
                ) AS geom
            FROM pa_bottlenecks
        ),
        both_states AS (
            SELECT * FROM nj
            UNION
            SELECT * FROM pa
        )

    SELECT
        ROW_NUMBER() OVER() AS unique_id,
        *
    FROM both_states
