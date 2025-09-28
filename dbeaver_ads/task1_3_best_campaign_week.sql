WITH ads AS (
	SELECT fabd.ad_date , fc.campaign_name , COALESCE(fabd.value, 0) AS value
	FROM facebook_ads_basic_daily fabd
		LEFT JOIN facebook_campaign fc
	    	ON fc.campaign_id=fabd.campaign_id 
				UNION ALL
	SELECT gabd.ad_date, gabd.campaign_name, COALESCE(gabd.value, 0) AS value
	FROM google_ads_basic_daily gabd
)
SELECT date_trunc('week', ad_date) ::date AS week, campaign_name, SUM(value) AS total_week_value
FROM ads 
	GROUP BY 1, 2
	ORDER BY total_week_value desc
	LIMIT 1
