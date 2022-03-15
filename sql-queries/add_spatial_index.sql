CREATE INDEX ON events USING GIST(geom);

CREATE INDEX ON bottlenecks USING GIST(geom);
