SELECT

	SUM(deal.property_hs_arr * DATEDIFF('months', deal.property_commencement_date::DATE, deal.property_end_date::DATE)) /  SUM(deal.property_hs_arr) AS wtd_duration
FROM hubs.deal AS deal
INNER JOIN hubs.deal_pipeline_stage AS stage
	ON deal.deal_pipeline_stage_id = stage.stage_id
	AND stage.label = '#09 WON'
WHERE
	1 = 1
	AND deal.deal_pipeline_id = 19800993 -- id for sales_pipeline_v2
	AND deal.property_hs_arr > 0
