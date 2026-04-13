with source as (

    select *
    from {{ source('airbnb_raw', 'raw_hosts') }}

),

hosts_deduplicated as (

    select distinct
        host_id::number as host_id,
        host_name::varchar as host_name,
        host_location::varchar as host_location,
        host_about::varchar as host_about,
        host_is_superhost,
        host_listings_count::number as host_listings_count,
        host_has_profile_pic,
        host_identity_verified,
        calculated_host_listings_count_entire_homes,
        calculated_host_listings_count_private_rooms,
        calculated_host_listings_count_shared_rooms

    from source
    where host_id is not null

)

select
    host_id,
    host_name,
    host_location,
    host_about,
    host_is_superhost,
    host_listings_count,
    host_has_profile_pic,
    host_identity_verified,
    calculated_host_listings_count_entire_homes,
    calculated_host_listings_count_private_rooms,
    calculated_host_listings_count_shared_rooms
from hosts_deduplicated