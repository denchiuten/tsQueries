SELECT DISTINCT
		dc.company_id,
		deal.property_customer_success_manager AS csm_id
	FROM hubs.deal_company AS dc
	INNER JOIN hubs.deal AS deal
		ON dc.deal_id = deal.deal_id
		AND deal.deal_pipeline_id = 11272062 -- ID for Customer Success deal pipeline
	WHERE
		1 = 1
		AND dc.type_id = 5