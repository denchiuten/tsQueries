CREATE OR REPLACE VIEW hubs.vw_deal_stage_history AS
SELECT
	ds.deal_id,
	dps.stage_id,
	dps.label AS stage_name,
	ds.date_entered AS valid_from,
	LEAD(date_entered) OVER (
		PARTITION BY 
			ds.deal_id
		ORDER BY 
			ds.date_entered
	) AS valid_to
FROM hubs.deal_stage AS ds
INNER JOIN hubs.deal_pipeline_stage AS dps
	ON ds.value = dps.stage_id
	AND dps._fivetran_deleted IS FALSE
INNER JOIN hubs.deal AS d
	ON ds.deal_id = d.deal_id
	AND d.deal_pipeline_id = 19800993 -- id for sales_pipeline_v2
	AND d._fivetran_deleted IS FALSE;