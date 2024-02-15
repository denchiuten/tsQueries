
SELECT
	d.deal_id,
	d.property_dealname AS deal_name,
	dps.label AS final_stage,
	hist.label AS int_stage
FROM hubs.deal AS d
INNER JOIN hubs.deal_pipeline_stage AS dps
	ON d.deal_pipeline_stage_id = dps.stage_id
	AND dps.pipeline_id = 19800993 -- sales pipeline v2
	AND dps.label IN ('#09 WON', '#10 Closed lost')
	AND dps._fivetran_deleted IS FALSE
LEFT JOIN (
	SELECT DISTINCT
		ds.deal_id,
		stage.label
	FROM hubs.deal_stage AS ds
	INNER JOIN hubs.deal_pipeline_stage AS stage
		ON ds.value = stage.stage_id
		AND stage.label NOT IN ('#09 WON', '#10 Closed lost')
		AND stage._fivetran_deleted IS FALSE
) AS hist
	ON d.deal_id = hist.deal_id
WHERE
	1 = 1
	AND d._fivetran_deleted IS FALSE
