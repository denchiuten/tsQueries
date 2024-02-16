
SELECT
	d.deal_id,
	d.property_dealtype AS deal_type,
	com.property_name AS company_name,
	d.property_dealname AS deal_name,
	dps.label AS final_stage,
	hist.label AS int_stage,
	hist.probability AS hubspot_probability,
	d.property_createdate::DATE AS created_date,
	d.property_closedate::DATE AS close_date
FROM hubs.deal AS d
INNER JOIN hubs.deal_pipeline_stage AS dps
	ON d.deal_pipeline_stage_id = dps.stage_id
	AND dps.pipeline_id = 19800993 -- sales pipeline v2
	AND dps.label IN ('#09 WON', '#10 Closed lost')
	AND dps._fivetran_deleted IS FALSE
INNER JOIN hubs.deal_company AS dc
	ON d.deal_id = dc.deal_id
	AND dc.type_id = 5 -- primary company association type
INNER JOIN hubs.company AS com
	ON dc.company_id = com.id
LEFT JOIN (
	SELECT DISTINCT
		ds.deal_id,
		stage.label,
		stage.probability
	FROM hubs.deal_stage AS ds
	INNER JOIN hubs.deal_pipeline_stage AS stage
		ON ds.value = stage.stage_id
		AND stage._fivetran_deleted IS FALSE
		AND stage.pipeline_id = 19800993 -- sales pipeline v2
) AS hist
	ON d.deal_id = hist.deal_id
WHERE
	1 = 1
	AND d._fivetran_deleted IS FALSE
