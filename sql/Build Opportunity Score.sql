create or replace table yelp_analysis.city_scores as
with base as(
select *,
  -- Normalize demand
  (total_reviews - min(total_reviews) over()) /
  (max(total_reviews) over() - min(total_reviews) over()) as norm_demand,

  -- Normalize competition
  (restaurant_count - min(restaurant_count) over()) /
  (max(restaurant_count) over() - min(restaurant_count) over()) as norm_competition,

  -- Normalize rating
  (avg_rating - min(avg_rating) over()) / 
  (max(avg_rating) over() - min(avg_rating) over()) as norm_rating

from yelp_analysis.city_metrics
)
select *,
  -- Final Opportunity score
  round(norm_demand * 0.5) - (norm_competition * 0.3) - (norm_rating * 0.2)
  as opportunity_score
from base;

select * from yelp_analysis.city_scores;

select city, state, total_reviews, avg_review_per_restaurant, restaurant_count, round(opportunity_score,5) as opportunity_score
from yelp_analysis.city_scores
where restaurant_count >=50
order by opportunity_score DESC;

-- New Orleans: Strong food culture + active customers + still room for quality improvement
-- => VERY strong candidate
-- Philadelphia: Big market but saturated → harder to enter
-- => High reward, high risk
-- Nashville: Growing city with healthy balance → strong expansion target
-- => Very realistic business choice

-- After filtering out low-sample cities, I found that cities like New Orleans and Nashville offer the best opportunities due to strong customer demand and moderate competition, while extremely large markets like Philadelphia show higher saturation despite high demand

