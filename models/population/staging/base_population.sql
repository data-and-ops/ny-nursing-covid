//init load

with initialLoad as (
    select * from {{ ref('populationData') }}
)
select * from intialLoad

