SELECT
	deal.property_dealname AS deal,
	com.property_name AS child_name
FROM hubs.deal AS deal
INNER JOIN hubs.deal_company AS dc
	ON deal.deal_id = dc.deal_id
	AND dc.type_id = 5 -- primary company only
INNER JOIN hubs.company AS com
	ON dc.company_id = com.id
INNER JOIN hubs.deal_pipeline_stage AS stage
	ON deal.deal_pipeline_stage_id = stage.stage_id
	AND stage.label = '#09 WON'
WHERE
	1 = 1
	AND deal.property_arr_usd_ + deal.property_hs_acv + deal.property_hs_tcv > 0