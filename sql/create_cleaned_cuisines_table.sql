create or replace table yelp_analysis.cleaned_cuisines as
select *
from yelp_analysis.restaurant_cuisines
where lower (cuisine) not like '%restaurant%' and lower(cuisine) not like '%food%';

select city, state, count(*) AS sushi_places,
  avg (stars) as avg_rating,
  sum(review_count) as total_reviews
from yelp_analysis.cleaned_cuisines
where lower (cuisine) like '%sushi%'
group by city, state
having sushi_places >=10
order by total_reviews DESC;

select city, state, count(*) AS coffee_places,
  avg (stars) as avg_rating,
  sum(review_count) as total_reviews
from yelp_analysis.cleaned_cuisines
where lower (cuisine) like '%coffee%'
group by city, state
having coffee_places >=10
order by total_reviews DESC;

-- Philadelphia: Customers are active, but satisfaction is relatively low → strong opportunity to differentiate with quality.
-- New Orleans: Customers are already relatively satisfied → harder to outperform existing players.
-- Nashville: Growing market with manageable competition and room for quality improvement.

--=>For the coffee segment, Philadelphia presents the strongest opportunity due to high customer demand combined with relatively low satisfaction levels, indicating unmet expectations despite a competitive market.

