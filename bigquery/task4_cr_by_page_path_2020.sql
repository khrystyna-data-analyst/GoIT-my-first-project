WITH session_starts AS (
  SELECT
    user_pseudo_id || CAST((SELECT value.int_value FROM unnest(event_params) WHERE key = 'ga_session_id') AS string) AS user_session_id,
  (SELECT value.string_value FROM unnest(event_params) WHERE key = 'page_location') AS page_location,
  COALESCE 
      (regexp_extract(
        (SELECT value.string_value FROM unnest(event_params) WHERE key = 'page_location'), 
        r'^(?:https?:\/\/)?[^\/]+(\/[^\?#]*)'), 
    '/') AS page_path
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE _table_suffix BETWEEN '20200101' AND '20201231' 
    AND event_name = 'session_start'
),
purchases AS(
  SELECT
    user_pseudo_id || CAST((SELECT value.int_value FROM unnest(event_params) WHERE key = 'ga_session_id') AS string) AS user_session_id,
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE _table_suffix BETWEEN '20200101' AND '20201231' 
    AND event_name ='purchase')
SELECT ss.page_path,
   COUNT(DISTINCT ss.user_session_id) as sessions_count,
   COUNT(DISTINCT p.user_session_id) as purchases_count,
   ROUND((COUNT(DISTINCT p.user_session_id) / COUNT(DISTINCT ss.user_session_id)), 5) AS cr_visit_to_purchase
FROM session_starts ss 
  LEFT JOIN purchases p
    USING (user_session_id)
GROUP BY 1
ORDER BY 4 DESC
