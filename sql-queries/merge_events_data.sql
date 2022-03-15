CREATE TABLE events AS
    WITH
        nj AS (
            SELECT
                *,
                ST_SETSRID(
                    ST_POINT(longitude, latitude),
                    4326
                ) AS geom
            FROM nj_events
            WHERE longitude != 0 AND latitude != 0
        ),
        pa AS (
            SELECT
                *,
                ST_SETSRID(
                    ST_POINT(longitude, latitude),
                    4326
                ) AS geom
            FROM pa_events
            WHERE longitude != 0 AND latitude != 0
        ),
        both_states AS (
            SELECT * FROM nj
            union
            SELECT * FROM pa
        )

    SELECT
        ROW_NUMBER() OVER() AS unique_id,
        *
    FROM both_states
