create or replace table yelp_analysis.restaurant_cuisines as
select   business_id, city, state,stars, review_count,
        trim (category) as cuisine
from yelp_analysis.restaurants,
unnest (split(categories, ',')) category;

select * from yelp_analysis.restaurant_cuisines;



