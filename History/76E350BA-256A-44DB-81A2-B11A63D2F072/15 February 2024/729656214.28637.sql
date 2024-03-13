SELECT 
	stage.label
FROM hubs.deal_stage AS ds
INNER JOIN hubs.deal_pipeline_stage AS stage
	ON ds.value = stage.stage_id
WHERE ds.deal_id = 11997919762;