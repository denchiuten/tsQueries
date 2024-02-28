SELECT DISTINCT
		ds.deal_id,
		stage.label,
		stage.probability
	FROM hubs.deal_stage AS ds
	INNER JOIN hubs.deal_pipeline_stage AS stage
		ON ds.value = stage.stage_id
-- 		AND stage.label NOT IN ('#09 WON', '#10 Closed lost')
		AND stage._fivetran_deleted IS FALSE
		AND stage.pipeline_id = 19800993 -- sales pipeline v2