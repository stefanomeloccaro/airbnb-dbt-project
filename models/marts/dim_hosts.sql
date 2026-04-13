{{ config(materialized='table', schema='L2_MARTS') }}

select
    host_id,
    host_name,
    host_location,
    host_is_superhost,
    host_has_profile_pic,
    host_identity_verified,
    host_listings_count,

    case
        when host_is_superhost = true then 'superhost'
        when host_is_superhost = false then 'regular_host'
        else null
    end as host_type
from {{ ref('stg_hosts') }}
where host_id is not null