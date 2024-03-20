SELECT
	a.base_month,
	a.lead_month,
	SUM(a.acv) AS acv,
	SUM(a.acv_leading) AS acv_leading,
	SUM(a.acv_leading) / SUM(a.acv) AS net_revenue_retention
FROM (
	SELECT
		all_dates.obs_date AS base_month,
		ADD_MONTHS(all_dates.obs_date, 12)::DATE AS lead_month,
		com.id AS company_id,
		com.property_name AS company_name,
		SUM(deal.property_acv_usd) AS acv,
		LEAD(SUM(deal.property_acv_usd), 12) OVER(
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
	INNER JOIN (
		SELECT DISTINCT
			DATE_TRUNC('month', d.date)::DATE AS obs_date
		FROM plumbing.dates AS d
		WHERE d.date <= CURRENT_DATE + 365
		
	) AS all_dates
		ON all_dates.obs_date BETWEEN deal.property_commencement_date AND deal.property_end_date
	WHERE
		1 = 1
		AND deal.property_arr_usd_ + deal.property_acv_usd + deal.property_amount_in_home_currency > 0
		AND deal._fivetran_deleted IS FALSE
	GROUP BY 1,2,3,4
) AS a
WHERE
	a.lead_month <= CURRENT_DATE
GROUP BY 1,2
ORDER BY 1,2