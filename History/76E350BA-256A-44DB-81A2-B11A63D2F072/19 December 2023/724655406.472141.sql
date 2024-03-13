SELECT
	ROUND(SUM(deal.property_hs_acv) / 1e6, 2) AS acv, 
	MAX(deal._fivetran_synced)::DATETIME AS data_up_to
FROM hubs.deal AS deal
INNER JOIN hubs.deal_pipeline_stage AS stage
	ON deal.deal_pipeline_stage_id = stage.stage_id
	AND stage.label = '#09 WON'
WHERE
	1 = 1
	AND deal.property_end_date >= CURRENT_DATE
AND deal.property_hs_acv > 0