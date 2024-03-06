SELECT DISTINCT 
	com.property_name AS company_name,
	com.id AS company_id
FROM hubs.deal AS deal
INNER JOIN hubs.deal_company AS dc
	ON deal.deal_id = dc.deal_id
	--AND dc.type_id = 5 -- primary company association type
INNER JOIN hubs.company AS com
	ON dc.company_id = com.id
WHERE
	1 = 1
	AND deal.deal_pipeline_stage_id = 48199178 -- won deals only