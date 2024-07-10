SELECT 
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

SELECT DISTINCT label
FROM hubs.deal_pipeline_stage