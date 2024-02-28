SELECT
		deal.property_dealname AS deal_name,
		deal.deal_id
	FROM hubs.deal AS deal
	INNER JOIN hubs.deal_pipeline AS pipeline
		ON deal.deal_pipeline_id = pipeline.pipeline_id
		AND pipeline.label = 'Customer Success'