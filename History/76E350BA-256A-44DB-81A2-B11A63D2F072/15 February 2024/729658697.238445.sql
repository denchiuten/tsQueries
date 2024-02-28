SELECT
	d.deal_id,
	d.property_dealname AS deal_name
FROM hubs.deal AS d
INNER JOIN hubs.deal_pipeline_stage AS dps
	ON d.deal_pipeline_stage_id = dps.stage_id
	AND dps.pipeline_id = 19800993 -- sales pipeline v2
	AND dps.label IN ('#09 WON', '#10 Closed lost')
	AND dps._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND d._fivetran_deleted IS FALSE