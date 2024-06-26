SELECT
	a.base_month,
	a.lead_month,
	SUM(a.acv) AS acv,
	SUM(a.acv_leading) AS acv_leading,
	SUM(a.acv_leading) / SUM(a.acv) AS net_revenue_retention,
	COUNT(DISTINCT CASE WHEN a.acv > 0 THEN a.company_id END) AS base_actives
FROM (
	SELECT
		all_dates.obs_date AS base_month,
		ADD_MONTHS(all_dates.obs_date, 12)::DATE AS lead_month,
		com.id AS company_id,
		com.property_name AS company_name,
		SUM(CASE WHEN all_dates.obs_date BETWEEN deal.property_commencement_date AND deal.property_end_date THEN deal.property_acv_usd ELSE 0 END) AS acv,
		LEAD(SUM(CASE WHEN all_dates.obs_date BETWEEN deal.property_commencement_date AND deal.property_end_date THEN deal.property_acv_usd ELSE 0 END), 12) OVER(
			PARTITION BY com.id
			ORDER BY  all_dates.obs_date
		) AS acv_leading
	FROM hubs.deal AS deal
	INNER JOIN hubs.deal_company AS dc
		ON deal.deal_id = dc.deal_id
		AND dc.type_id = 5 -- primary company only
	INNER JOIN hubs.company AS com
		ON dc.company_id = com.id
	INNER JOIN hubs.deal_pipeline_stage AS stage
		ON deal.deal_pipeline_stage_id = stage.stage_id
		AND stage.label = '#09 WON'
	CROSS JOIN (
		SELECT DISTINCT
			LAST_DAY(d.date)::DATE AS obs_date
		FROM plumbing.dates AS d
		WHERE d.date <= ADD_MONTHS(CURRENT_DATE, 12)
		
	) AS all_dates
	WHERE
		1 = 1
		AND deal.property_arr_usd_ + deal.property_acv_usd + deal.property_amount_in_home_currency > 0
		AND deal._fivetran_deleted IS FALSE
	GROUP BY 1,2,3,4
) AS a
WHERE
	1 = 1 
	AND a.lead_month <= CURRENT_DATE
	AND a.acv > 0
GROUP BY 1,2
