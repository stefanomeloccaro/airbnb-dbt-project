-- Singular test
select fr.*
from {{ ref('fct_reviews') }} fr
left join {{ ref('dim_listings') }} dl
    on fr.listing_id = dl.listing_id
where dl.listing_id is null