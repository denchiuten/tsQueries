SELECT
	SUM(deal.property_hs_acv)
FROM hubs.deal AS deal
INNER JOIN hubs.deal_pipeline_stage AS stage
	ON deal.deal_pipeline_stage_id = stage.stage_id
	AND stage.label = '#09 WON'
WHERE
	1 = 1
	AND deal.property_end_date >= CURRENT_DATE