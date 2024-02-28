SELECT
	d.deal_id,
	d.property_dealname AS deal_name,
	dps.label AS current_stage
FROM hubs.deal AS d
INNER JOIN hubs.deal_pipeline_stage AS dps
	ON d.deal_pipeline_stage_id = dps.pipeline_id

WHERE
	1 = 1
	AND d.deal_pipeline_id = 19800993 -- ID for 'Sales Pipeline v2'