select categories
from `yelp_analysis.business`;

select distinct(trim(category)) category, count(*) total_appearance
from `yelp_analysis.business`,
unnest (split(categories, ',')) category
group by category
order by total_appearance DESC;

