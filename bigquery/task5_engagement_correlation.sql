WITH sessions_and_engagement AS (
  SELECT
    user_pseudo_id || CAST((SELECT value.int_value FROM unnest(event_params) WHERE key = 'ga_session_id') AS string) AS user_session_id,
    SUM(
      COALESCE 
        ((SELECT value.int_value FROM unnest(event_params) WHERE key = 'engagement_time_msec'), 0)) AS total_engagement_time,
    CASE
      WHEN 
        SUM(COALESCE(SAFE_CAST((SELECT value.string_value FROM unnest(event_params) WHERE key = 'session_engaged') AS INTEGER), 0)) > 0
      THEN 1
      ELSE 0
      END
    AS session_engaged
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  GROUP BY 1
  HAVING SUM(CASE WHEN event_name='session_start' THEN 1 ELSE 0 END) > 0
),
purchases AS(
  SELECT
    user_pseudo_id || CAST((SELECT value.int_value FROM unnest(event_params) WHERE key = 'ga_session_id') AS string) AS user_session_id,
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE event_name ='purchase')
SELECT 
  ROUND(corr(CAST(se.session_engaged AS FLOAT64), CAST((CASE WHEN p.user_session_id IS NOT NULL THEN 1 ELSE 0 END) AS FLOAT64)), 4) AS corr_engaged_to_purchase, 
  ROUND(corr(CAST(se.total_engagement_time AS FLOAT64), CAST((CASE WHEN p.user_session_id IS NOT NULL THEN 1 ELSE 0 END) AS FLOAT64)), 4) AS corr_time_to_purchase, 
  COUNT(*) AS how_many_sessions
FROM sessions_and_engagement se
  LEFT JOIN purchases p
    USING (user_session_id)
