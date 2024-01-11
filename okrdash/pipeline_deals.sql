SELECT
	deal.deal_id,
	stage.label AS stage,
	deal.property_dealname AS deal,
	com.property_name AS company_child,
	cp.parent_name As company_parent,
	COALESCE(com.property_sector_grouped_, '*Sector Missing') AS sector,
	COALESCE(com.property_country_menu_, '*Country Missing') AS country,
	deal.property_hs_createdate::DATE AS date_created,
	deal.property_end_date::DATE AS end_date, 
	owner.first_name AS owner_first_name,
	owner.last_name AS owner_last_name,
	owner.email AS owner_email,
	COALESCE(deal.property_hs_tcv,0) AS tcv,
	COALESCE(deal.property_hs_acv,0) AS acv,
	COALESCE(deal.property_hs_arr,0) AS arr,
	MAX(MAX(deal._fivetran_synced)) OVER()::TIMESTAMP AS last_updated	
FROM hubs.deal AS deal
INNER JOIN hubs.deal_company AS dc
	ON deal.deal_id = dc.deal_id
	AND dc.type_id = 5 -- primary company only
INNER JOIN hubs.company AS com
	ON dc.company_id = com.id
LEFT JOIN hubs.vw_child_to_parent AS cp
	ON com.id = cp.child_id
INNER JOIN hubs.owner AS owner
	ON deal.owner_id = owner.owner_id
INNER JOIN hubs.deal_pipeline_stage AS stage
	ON deal.deal_pipeline_stage_id = stage.stage_id
WHERE
	1 = 1
	AND deal.deal_pipeline_id = 19800993
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15