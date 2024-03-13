SELECT DISTINCT
	ds.deal_id,
	stage.label,
	stage.probability
FROM hubs.deal_stage AS ds
INNER JOIN hubs.deal_pipeline_stage AS stage
	ON ds.value = stage.stage_id
--	AND stage.pipeline_id = 19800993 -- sales pipeline v2
WHERE ds.deal_id = 9889971774