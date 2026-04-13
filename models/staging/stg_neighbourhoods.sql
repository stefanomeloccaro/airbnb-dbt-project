select
    md5(
        coalesce(neighbourhood_group, '') || '|' || coalesce(neighbourhood, '')
    ) as neighbourhood_id,

    neighbourhood_group::varchar as neighbourhood_group,
    neighbourhood::varchar as neighbourhood

from {{ source('airbnb_raw', 'raw_neighbourhoods') }}
where neighbourhood is not null