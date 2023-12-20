SELECT	deal.deal_id,
	stage.label AS stage,	deal.property_dealname AS deal,	com.property_name AS company_child,	cp.parent_name As company_parent,	COALESCE(com.property_sector_grouped_, '*Sector Missing') AS sector,	COALESCE(com.property_country_menu_, '*Country Missing') AS country,	COALESCE(deal.property_hs_tcv,0) AS tcv,
	COALESCE(deal.property_arr_usd_, 0) AS arr,
	COALESCE(deal.property_hs_acv, 0) AS acvFROM hubs.deal AS dealINNER JOIN hubs.deal_company AS dc	ON deal.deal_id = dc.deal_id	AND dc.type_id = 5 -- primary company onlyINNER JOIN hubs.company AS com	ON dc.company_id = com.idLEFT JOIN hubs.vw_child_to_parent AS cp	ON com.id = cp.child_idINNER JOIN hubs.deal_pipeline_stage AS stage	ON deal.deal_pipeline_stage_id = stage.stage_id
	AND stage.label NOT IN ('#10 Closed lost', '#11 Backburner')WHERE	1 = 1	AND deal.deal_pipeline_id = 19800993 -- sales_v2 pipeline
	AND (deal.property_end_date IS NULL OR deal.property_end_date >= CURRENT_DATE)
ORDER BY 
	2,8 DESC