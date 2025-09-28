WITH ads_by_source AS (
SELECT ad_date, 'Facebook Ads' AS media_source, 
    spend, impressions, reach, clicks, leads, value
FROM facebook_ads_basic_daily
UNION ALL
SELECT ad_date, 'Google Ads' AS media_source,
    spend, impressions, reach, clicks, leads, value
FROM google_ads_basic_daily
)
SELECT ad_date ::date, media_source,
	ROUND(MIN(spend) ::NUMERIC, 2) AS min_spend, 
	ROUND(MAX(spend) ::NUMERIC, 2) AS max_spend,
	ROUND(AVG(spend) ::NUMERIC, 2) AS avg_spend,
	ROUND(MIN(impressions) ::NUMERIC, 2) AS min_impressions,
	ROUND(MAX(impressions) ::NUMERIC, 2) AS max_impressions,
	ROUND(AVG(impressions) ::NUMERIC, 2) AS avg_impressions,
	ROUND(MIN(clicks) ::NUMERIC, 2) AS min_clicks,
	ROUND(MAX(clicks) ::NUMERIC, 2) AS max_clicks,
	ROUND(AVG(clicks) ::NUMERIC, 2) AS avg_clicks,
	ROUND(MIN(value) ::NUMERIC, 2) AS min_value,
	ROUND(MAX(value) ::NUMERIC, 2) AS max_value,
	ROUND(AVG(value) ::NUMERIC, 2) AS avg_value
FROM ads_by_source 
GROUP BY ad_date ::date, media_source
ORDER BY ad_date ::date, media_source
