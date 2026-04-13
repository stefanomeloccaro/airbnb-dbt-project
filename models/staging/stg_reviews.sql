with source as (

    select *
    from {{ source('airbnb_raw', 'raw_reviews') }}

),

cleaned as (

    select
        listing_id::number as listing_id,
        id::number as review_id,
        try_to_date(Date, 'DD/MM/YYYY') as review_date,
        reviewer_name::varchar as reviewer_name,
        comments::varchar as review_text
    from source

)

select *
from cleaned