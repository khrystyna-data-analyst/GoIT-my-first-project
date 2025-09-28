WITH first AS (
	SELECT fabd.ad_date , fc.campaign_name , COALESCE(fabd.reach, 0) AS reach
	FROM facebook_ads_basic_daily fabd
		LEFT JOIN facebook_campaign fc
	    	ON fc.campaign_id=fabd.campaign_id 
				UNION ALL
	SELECT gabd.ad_date, gabd.campaign_name, COALESCE(gabd.reach, 0) AS reach
	FROM google_ads_basic_daily gabd
),
second AS(
	SELECT date_trunc('month', ad_date) ::date AS month_start, 
		   campaign_name, 
		   ROUND(SUM(reach) ::NUMERIC, 2) AS total_month_reach
	FROM first
		GROUP BY 1, 2
),
third AS (
	SELECT *, 
		LAG(total_month_reach, 1) OVER (PARTITION BY campaign_name ORDER BY month_start) AS prev_total_month_reach,
		ROUND(ABS(total_month_reach-LAG(total_month_reach, 1) OVER (PARTITION BY campaign_name ORDER BY month_start)) ::NUMERIC, 2) AS total_abs_diff
	FROM second)
SELECT *
FROM third
WHERE prev_total_month_reach IS NOT NULL
	ORDER BY total_abs_diff DESC, month_start, campaign_name
	LIMIT 1
