--init load
with initialLoad as (
    select * from {{ ref('covid19_nursing') }}
)
select * from initialLoad


