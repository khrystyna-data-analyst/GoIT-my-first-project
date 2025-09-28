WITH ads AS (
SELECT ad_date, 
    spend, value
FROM facebook_ads_basic_daily
UNION ALL
SELECT ad_date::date AS ad_date,
    spend, value
FROM google_ads_basic_daily
)
SELECT ad_date,
	ROUND(((SUM(value) ::NUMERIC-SUM(spend) ::NUMERIC)/SUM(spend) ::NUMERIC)*100,2) as ROMI 
FROM ads 
GROUP BY ad_date
	 HAVING SUM(spend) > 0
ORDER BY romi DESC
LIMIT 5
