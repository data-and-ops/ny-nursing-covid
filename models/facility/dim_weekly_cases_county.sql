with final as (
  -- produce a list of weekly counts by county
  select 
    date_trunc(week_ending, WEEK) as week_ending,
    f.county,
    sum(residents_weekly_confirmed_covid19) as residents_weekly_confirmed_covid19_count,
    sum(residents_weekly_all_deaths) as residents_weekly_all_deaths_count,
    sum(residents_weekly_covid19_deaths) as residents_weekly_covid19_deaths_count,
    sum(number_of_all_beds) as number_of_all_beds_count,
    sum(total_number_of_occupied_beds) as total_number_of_occupied_beds_count,
    p.y2022 as population
 
  from base_facility f

  left join base_population p on trim(f.county) = trim(p.area)
  group by week_ending, county, population
  order by week_ending desc
),

select * from final