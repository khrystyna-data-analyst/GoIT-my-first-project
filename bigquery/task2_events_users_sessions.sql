SELECT TIMESTAMP_MICROS(event_timestamp) AS event_timestamp, user_pseudo_id, 
        (SELECT value.int_value FROM unnest (event_params) WHERE key = 'ga_session_id') AS session_id, 
        event_name,geo.country AS country, device.category AS device_category,
        traffic_source.source AS source, traffic_source.medium AS medium, traffic_source.name AS campaign
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE _table_suffix BETWEEN '20210101' AND '20211231' 
    AND event_name in ('session_start', 'view_item', 'add_to_cart', 'begin_checkout', 'add_shipping_info', 'add_payment_info', 'purchase')
