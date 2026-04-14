create or replace table yelp_analysis.city_scores_v2 as
with filtered as (
    select * from yelp_analysis.city_metrics
    where restaurant_count >=50 -- remove tiny cities
    and total_reviews >= 1000 -- rensure real demand
),
base as (
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
  from filtered 
)

select * ,
  (norm_demand * 0.5) - (norm_competition * 0.3) - (base.norm_rating * 0.2)
  as opportunity_score
from base;

select * from yelp_analysis.city_scores_v2
order by opportunity_score DESC;

