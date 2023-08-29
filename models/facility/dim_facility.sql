with base_facility as (
  select * from {{ ref('base_facility') }}
),

final as (
  -- produce a summary list by facility
  select 
    federal_provider_number,
    provider_name,
    provider_city,
    county,
    max(residents_total_all_deaths) as residents_total_all_deaths,
    max(residents_total_covid19_deaths) as residents_total_covid19_deaths
 
  from base_facility f 
  group by federal_provider_number, provider_name, provider_city, county
  order by residents_total_covid19_deaths desc 
)

select * from final