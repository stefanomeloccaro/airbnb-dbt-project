-- Singular test
select *
from {{ ref('fct_reviews') }}
where 1=1
    and (review_id is null
        or listing_id is null
        or host_id is null
        or neighbourhood_id is null)