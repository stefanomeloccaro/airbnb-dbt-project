{{ config(materialized='table', schema='L2_MARTS') }}

select distinct
    neighbourhood_id,
    neighbourhood_group,
    neighbourhood
from {{ ref('stg_neighbourhoods') }}
where neighbourhood is not null