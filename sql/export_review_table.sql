create or replace table yelp_analysis.review_export as
SELECT business_id, stars, text
FROM yelp_analysis.review;

EXPORT DATA OPTIONS (
  uri='gs://yelp-dataset-emma/reviews_*.json',
  format='JSON',
  overwrite=true
)
AS
SELECT business_id, stars, text
FROM yelp_analysis.review