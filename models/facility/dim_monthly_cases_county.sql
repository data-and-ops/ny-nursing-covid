with base_facility as (
  select * from {{ ref('base_facility') }}
),

base_population as (
  select * from {{ ref('base_population') }}
),

final as (
  -- produce a list of monthly counts by county
  -- this does not adjust for partial weeks and will have disproportionate amounts per month
  select 
    date_trunc(week_ending, MONTH) as month_ending,
    f.county,
    sum(residents_weekly_confirmed_covid19) as residents_monthly_confirmed_covid19_count,
    sum(residents_weekly_all_deaths) as residents_monthly_all_deaths_count,
    sum(residents_weekly_covid19_deaths) as residents_monthly_covid19_deaths_count,
    sum(number_of_all_beds) as number_of_all_beds_count,
    sum(total_number_of_occupied_beds) as total_number_of_occupied_beds_count,
    p.y2022 as population
 
  from base_facility f

  left join base_population p on trim(f.county) = trim(p.area)
  group by month_ending, county, population
  order by month_ending desc
)

select * from final