WITH first AS (
  SELECT date(TIMESTAMP_MICROS(event_timestamp)) AS event_date, 
  user_pseudo_id || CAST((select value.int_value FROM unnest(event_params) WHERE key = 'ga_session_id') AS string) AS user_session_id,
  traffic_source.source AS source, traffic_source.medium AS medium, traffic_source.name AS campaign, event_name
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE _table_suffix BETWEEN '20210101' AND '20211231' 
    AND event_name IN ('session_start','add_to_cart','begin_checkout','purchase')
),
second AS(
  SELECT event_date, source, medium, campaign,
   COUNT(DISTINCT user_session_id) AS user_sessions_count,
   COUNT(DISTINCT CASE WHEN event_name = 'add_to_cart' THEN user_session_id END) AS added_to_cart_count,
   COUNT(DISTINCT CASE WHEN event_name = 'begin_checkout' THEN user_session_id END) AS began_checkout_count,
   COUNT(DISTINCT CASE WHEN event_name = 'purchase' THEN user_session_id END) AS purchased_count 
  FROM first 
  GROUP BY 1, 2, 3, 4)
SELECT event_date, source, medium, campaign, user_sessions_count,
  ROUND((added_to_cart_count / user_sessions_count), 5) AS visit_to_cart, 
  ROUND((began_checkout_count / user_sessions_count), 5) AS visit_to_checkout, 
  ROUND((purchased_count / user_sessions_count), 5) AS visit_to_purchase 
FROM second
ORDER BY 1 DESC
