with munis as (
    select
        mun_label,
        st_setsrid(geom, 4326) as geom
    from municipal_boundaries
    where dvrpc_reg = 'Yes'
)
select
    m.mun_label,
    COUNT(b.*) as num_bottlenecks,
    m.geom
from
    munis m
left join
    bottlenecks b
on
    st_within(st_setsrid(b.geom, 4326), m.geom)
group by
    m.mun_label, m.geom
