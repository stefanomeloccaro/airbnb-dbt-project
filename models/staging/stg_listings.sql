with source as (

    select *
    from {{ source('airbnb_raw', 'raw_listings') }}

),

cleaned as (

    select distinct
        -- identifiers
        id::number as listing_id,
        host_id::number as host_id,

        -- listing info
        name::varchar as listing_name,
        description::varchar as description,

        property_type::varchar as property_type,
        room_type::varchar as room_type,

        -- location
        neighbourhood_cleansed::varchar as neighbourhood,
        neighbourhood_group_cleansed::varchar as neighbourhood_group,
        TRY_CAST(REPLACE(latitude, ',', '.') AS FLOAT) AS latitude,
        TRY_CAST(REPLACE(longitude, ',', '.') AS FLOAT) AS longitude,

        -- capacity
        accommodates::number as accommodates,
        bedrooms::number as bedrooms,
        beds::number as beds,
        TRY_CAST(REPLACE(TRIM(bathrooms), ',', '.') AS FLOAT) AS bathrooms,
        amenities,

        -- availability
        has_availability,
        minimum_nights,
        maximum_nights,


        availability_30::number as availability_30,
        availability_60::number as availability_60,
        availability_90::number as availability_90,
        availability_365::number as availability_365,

        -- reviews
        number_of_reviews::number as number_of_reviews,
        number_of_reviews_ltm::number as number_of_reviews_ltm,
        number_of_reviews_l30d::number as number_of_reviews_l30d,
        availability_eoy,

        TRY_CAST(REPLACE(TRIM(review_scores_rating), ',', '.') AS FLOAT) AS review_scores_rating,
        TRY_CAST(REPLACE(TRIM(review_scores_cleanliness), ',', '.') AS FLOAT) AS review_scores_cleanliness,
        TRY_CAST(REPLACE(TRIM(review_scores_location), ',', '.') AS FLOAT) AS review_scores_location,
        TRY_CAST(REPLACE(TRIM(review_scores_value), ',', '.') AS FLOAT) AS review_scores_value

    from source

)

select *
from cleaned