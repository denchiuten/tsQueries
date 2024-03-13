SELECT
	deal.deal_id,
	com.property_name AS company,
	com.property_sector_grouped_ AS sector,
	deal.property_dealname AS deal,
	current_stage.label AS current_stage,
	int_stages.label AS int_stage
	ds._fivetran_start::DATE AS date_entered,
	ds._fivetran_end::DATE AS date_exited
FROM hubs.deal AS deal
INNER JOIN hubs.deal_pipeline_stage AS current_stage
	ON deal.deal_pipeline_stage_id = current_stage.stage_id
INNER JOIN hubs.deal_company AS dc
	ON deal.deal_id = dc.deal_id
	AND dc.type_id = 5 -- primary company association type
INNER JOIN hubs.company AS com
	ON dc.company_id = com.id
INNER JOIN hubs.deal_stage AS ds
	ON deal.deal_id = ds.deal_id
INNER JOIN hubs.deal_pipeline_stage AS int_stages
	ON ds.value = int_stages.stage_id

WHERE
	1 = 1
	AND deal.deal_pipeline_id = 19800993 -- ID for 'Sales Pipeline v2'