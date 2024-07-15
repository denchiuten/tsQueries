SELECT 
	deal._fivetran_synced AS last_updated,
	stage.label AS stage,
	deal.property_dealtype AS deal_type,
	deal.deal_id,
	deal.property_dealname AS deal_name,
	com.id AS company_id,
	com.property_name AS company_name,
	deal.property_createdate::DATE AS deal_created,
	deal.property_closedate::DATE AS deal_closed,
	deal.property_commencement_date::DATE AS commencement_date,
	deal.property_end_date::DATE AS end_date,
	CURRENT_DATE BETWEEN deal.property_closedate AND deal.property_end_date AS active_boolean,
	DATE_TRUNC('quarter', CURRENT_DATE) - 1 BETWEEN deal.property_closedate AND deal.property_end_date AS active_last_quarter_boolean,
	deal.property_acv_usd AS acv,
	deal.property_amount_in_home_currency AS tcv
FROM hubs.deal AS deal
INNER JOIN hubs.deal_company AS dc
	ON deal.deal_id = dc.deal_id
	AND dc.type_id = 5 -- primary company association type
INNER JOIN hubs.company AS com
	ON dc.company_id = com.id
INNER JOIN hubs.deal_pipeline_stage AS stage
	ON deal.deal_pipeline_stage_id = stage.stage_id
	AND stage.label IN ('#08 Contract','#09 WON')
WHERE
	1 = 1
	AND deal._fivetran_deleted IS FALSE
	AND deal.deal_pipeline_id = 19800993
