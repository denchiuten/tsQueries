SELECT
	CASE 
		WHEN stage.label = '#09 WON' AND CURRENT_DATE BETWEEN deal.property_commencement_date AND deal.property_end_date THEN 'Active Contracts'
		WHEN deal.property_dealtype = 'Renewal' AND deal.property_closedate BETWEEN CURRENT_DATE AND <Parameters.Waterfall End Date> AND stage.label <>'#09 WON' AND deal.property_hs_manual_forecast_category = 'COMMIT' THEN 'Commit - Renewals' 
		WHEN deal.property_dealtype = 'newbusiness' AND deal.property_closedate BETWEEN CURRENT_DATE AND <Parameters.Waterfall End Date> AND stage.label <>'#09 WON' AND deal.property_hs_manual_forecast_category = 'COMMIT' THEN 'Commit - New Deals' 
		END AS waterfall_category,
	deal.property_dealtype AS type,
	com.property_name AS company,
	stage.label AS stage,
	deal.deal_id,
	deal.property_dealname AS deal_name,
	deal.property_commencement_date::DATE AS commencement_date,
	deal.property_end_date::DATE AS end_date,
	deal.property_closedate::DATE AS close_date,
	deal.property_acv_usd AS ACV,
	deal.property_amount_in_home_currency AS TCV
FROM hubs.deal AS deal
INNER JOIN hubs.deal_pipeline_stage AS stage
	ON deal.deal_pipeline_stage_id = stage.stage_id
	AND stage.label <> '#10 Closed lost'
INNER JOIN hubs.deal_company AS dc
	ON deal.deal_id = dc.deal_id
	AND dc.type_id = 5 -- primary company association type
INNER JOIN hubs.company AS com
	ON dc.company_id = com.id
WHERE
	1 = 1
	AND deal._fivetran_deleted IS FALSE
	AND deal.deal_pipeline_id = 19800993
	AND waterfall_category IS NOT NULL

UNION ALL

SELECT
	'Contracts Expiring' AS waterfall_category,
	deal.property_dealtype AS type,
	com.property_name AS company,
	stage.label AS stage,
	deal.deal_id,
	deal.property_dealname AS deal_name,
	deal.property_commencement_date::DATE AS commencement_date,
	deal.property_end_date::DATE AS end_date,
	deal.property_closedate::DATE AS close_date,
	-deal.property_acv_usd AS ACV,
	-deal.property_amount_in_home_currency AS TCV
FROM hubs.deal AS deal
INNER JOIN hubs.deal_pipeline_stage AS stage
	ON deal.deal_pipeline_stage_id = stage.stage_id
	AND stage.label = '#09 WON'
INNER JOIN hubs.deal_company AS dc
	ON deal.deal_id = dc.deal_id
	AND dc.type_id = 5 -- primary company association type
INNER JOIN hubs.company AS com
	ON dc.company_id = com.id
WHERE
	1 = 1
	AND deal._fivetran_deleted IS FALSE
	AND deal.deal_pipeline_id = 19800993
	AND deal.property_commencement_date <= CURRENT_DATE
	AND deal.property_end_date BETWEEN CURRENT_DATE AND <Parameters.Waterfall End Date>