create or replace table yelp_analysis.city_metrics as
select city, state,
      count (*) as restaurant_count,
      avg(stars) as avg_rating,
      sum(review_count) as total_reviews,
      avg(review_count) as avg_review_per_restaurant
from yelp_analysis.restaurants
where is_open = 1 and city is not null
group by city, state
order by total_reviews DESC;

select * from yelp_analysis.city_metrics;

-- QUICK INSIGHT CHECK
---1. Highest demand cities
select city, state, total_reviews
from yelp_analysis.city_metrics
order by total_reviews DESC
limit 10; 

---2. Most competitive cities
select city, restaurant_count
from yelp_analysis.city_metrics
order by restaurant_count DESC
limit 10; 

---3. Lowest rating cities
select city, state, avg_rating
from yelp_analysis.city_metrics
where restaurant_count > 50
order by avg_rating DESC
limit 10;