create or replace table yelp_analysis.restaurants as
  select business_id, name, city, state, stars, review_count, is_open, categories
  from yelp_analysis.business
  where lower(categories) like '%restaurant%';

select *
from `yelp_analysis.restaurants`;

select count(*)
from yelp_analysis.restaurants
where city is null;

select count(*), count (distinct(business_id))
from `yelp_analysis.restaurants`