SELECT DISTINCT
		dc.company_id,
		deal.property_dealname,
		csm.first_name AS csm_first,
		csm.last_name AS csm_last
	FROM hubs.deal_company AS dc
	INNER JOIN hubs.deal AS deal
		ON dc.deal_id = deal.deal_id
		AND deal.deal_pipeline_id = 11272062 -- ID for Customer Success deal pipeline
		AND deal.property_customer_success_manager IS NOT NULL
	LEFT JOIN hubs.owner AS csm
		ON deal.property_customer_success_manager = csm.owner_id
	WHERE
		1 = 1
		AND dc.type_id = 5