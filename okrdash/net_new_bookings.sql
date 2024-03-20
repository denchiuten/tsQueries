SELECT
	com.property_name AS company_name,
	com.id AS company_id,
	SUM(ly.prior_year_acv) AS prior_year_acv,
	SUM(CASE WHEN d.property_dealtype = 'newbusiness' THEN d.property_acv_usd END) AS new_acv,
	SUM(CASE WHEN d.property_dealtype = 'Renewal' THEN d.property_acv_usd END) AS renewal_acv,
	SUM(CASE WHEN d.property_dealtype = 'Cross-sell/up-sell' THEN d.property_acv_usd END) AS upsell_xsell_acv
FROM hubs.deal AS d
INNER JOIN hubs.deal_company AS dc
	ON d.deal_id = dc.deal_id
	AND dc.type_id = 5 -- primary company association type
INNER JOIN hubs.company AS com
	ON dc.company_id = com.id

-- subquery to join on to find active deals signed last year
LEFT JOIN (
	SELECT 
		dc2.company_id,
		SUM(d2.property_acv_usd) AS prior_year_acv
	FROM hubs.deal AS d2
	INNER JOIN hubs.deal_company AS dc2
		ON d2.deal_id = dc2.deal_id
		AND dc2.type_id = 5 -- primary company association type
	WHERE	
		1 = 1
		AND d2._fivetran_deleted IS FALSE
		AND d2.property_acv_usd IS NOT NULL
		AND d2.property_hs_closed_won_date IS NOT NULL
		AND d2.deal_pipeline_id = 19800993 -- ID for salesv2 pipeline
		AND DATE_TRUNC('year', CURRENT_DATE) - 1 BETWEEN d2.property_commencement_date AND d2.property_end_date
	GROUP BY 1
) AS ly
	ON com.id = ly.company_id
WHERE
	1 = 1
	AND d._fivetran_deleted IS FALSE
	AND d.property_acv_usd IS NOT NULL
	AND d.property_hs_closed_won_date IS NOT NULL
	AND d.deal_pipeline_id = 19800993 -- ID for salesv2 pipeline
	AND EXTRACT(YEAR FROM d.property_hs_closed_won_date) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY 1,2

