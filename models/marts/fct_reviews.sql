{{ config(materialized='incremental', on_schema_change = 'fail', schema='L2_MARTS') }}

with reviews as (

    select
        review_id,
        listing_id,
        review_date,
        reviewer_name,
        review_text
    from {{ ref('stg_reviews') }}
    where review_id is not null
      and listing_id is not null

),

listings as (

    select
        listing_id,
        host_id,
        neighbourhood,
        neighbourhood_group
    from {{ ref('stg_listings') }}
    where listing_id is not null

),

neighbourhoods as (

    select
        md5(
            coalesce(neighbourhood_group, '') || '|' || coalesce(neighbourhood, '')
        ) as neighbourhood_id,
        neighbourhood_group,
        neighbourhood
    from {{ ref('stg_neighbourhoods') }}

)

select
    r.review_id,
    r.listing_id,
    l.host_id,
    n.neighbourhood_id,
    r.review_date,
    r.reviewer_name,
    r.review_text
from reviews r
left join listings l on r.listing_id = l.listing_id
left join neighbourhoods n on l.neighbourhood = n.neighbourhood and l.neighbourhood_group = n.neighbourhood_group

{% if is_incremental() %}
    where review_date > (SELECT MAX(review_date) FROM {{this}})
{% endif %}