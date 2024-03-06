SELECT DISTINCT
	com.property_name AS company_name,
	com.id AS company_id
FROM hubs.deal AS deal
LEFT JOIN hubs.deal_company AS dc
	ON deal.deal_id = dc.deal_id
	AND dc.type_id = 5 -- primary company association type
LEFT JOIN hubs.company AS com
	ON dc.company_id = com.id
WHERE
	1 = 1
	AND deal.deal_pipeline_stage_id = 19800993 -- won deals only