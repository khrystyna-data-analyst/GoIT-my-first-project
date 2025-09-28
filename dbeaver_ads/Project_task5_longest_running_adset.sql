WITH 
main AS (
	SELECT fabd.ad_date::date AS date, fa.adset_name, COALESCE(fabd.impressions, 0) AS impressions
	FROM facebook_ads_basic_daily fabd
		LEFT JOIN facebook_adset fa
		    ON fa.adset_id=fabd.adset_id
UNION ALL
	SELECT gabd.ad_date::date AS date, gabd.adset_name, COALESCE(gabd.impressions, 0) AS impressions
	FROM google_ads_basic_daily gabd
),
days AS (
	SELECT DISTINCT date, adset_name
	FROM main 
		WHERE impressions >0),				--only shows the days when there was an impression
ordering AS (
	SELECT date, adset_name,
		   LAG(date) OVER (PARTITION BY adset_name ORDER BY date) AS prev_date,
		 CASE WHEN (LAG(date) OVER (PARTITION BY adset_name ORDER BY date)) = date - INTERVAL '1 day'
		   THEN 0 ELSE 1					--'ranks' each row, 0 if unbreakable sequence, adds +1 if there's a break
		 END AS break																	-- this way makes a 'group'
	FROM days
),
grouping_g AS (
	SELECT date, adset_name, 
		   SUM(break) OVER (PARTITION BY adset_name ORDER BY date) AS sequence_group		--creates groups from the 'ranks'
	FROM ordering																					           --1 row=1 day
),
day_counting AS (											--each row - a campaign w/ it's start & end days + length of the period (adset_name may reapeat if there are a few different periods)
	SELECT adset_name,
		   MIN(date) AS start_date,
		   MAX(date) AS end_date,
		   COUNT(*) AS days									--counts rows(days) in each sequence_group
	FROM grouping_g
	GROUP BY adset_name, sequence_group
),
ranking AS (
	SELECT *, row_number() OVER(ORDER BY days DESC, start_date, end_date) AS number_of_the_row  --1st sorts the periods (longest to shortest), then 'ranks' the rows
	FROM day_counting
)
SELECT adset_name, start_date, end_date, days AS longest_period
FROM ranking
	WHERE number_of_the_row = 1								--which row has '1' as a row number, is the one with the longest period (it sorts internally only)