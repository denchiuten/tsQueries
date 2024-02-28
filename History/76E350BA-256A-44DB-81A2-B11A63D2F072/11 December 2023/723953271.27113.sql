SELECT
	d.deal_id,
	com.property_name AS company,
	com.property_sector_grouped_ AS sector,
	d.property_dealname AS deal,
	dps.label AS current_stage
FROM hubs.deal AS d
INNER JOIN hubs.deal_pipeline_stage AS dps
	ON d.deal_pipeline_stage_id = dps.stage_id
INNER JOIN hubs.deal_company AS dc
	ON deal.deal_id = dc.deal_id
	AND dc.type_id = 5 -- primary company association type
INNER JOIN hubs.company AS com
	ON dc.company_id = com.id

WHERE
	1 = 1
	AND d.deal_pipeline_id = 19800993 -- ID for 'Sales Pipeline v2'