SELECT
	deal.deal_id,
	stage.label AS stage,
	deal.property_dealname AS deal,
	com.property_name AS company_child,
	cp.parent_name As company_parent,
	COALESCE(opt.label, '*Sector Missing') AS sector,
	COALESCE(ind_opt.label, '*Industry Missing') AS industry,
	COALESCE(com.property_country_menu_, '*Country Missing') AS country,
	deal.property_hs_createdate::DATE AS date_created,
	deal.property_closedate::DATE AS close_date,
	deal.property_commencement_date::DATE AS start_date,
	deal.property_end_date::DATE AS end_date, 
	COALESCE(deal.property_amount_in_home_currency,0) AS tcv,
	COALESCE(deal.property_acv_usd,0) AS acv,
	COALESCE(deal.property_arr_usd_,0) AS arr,
	MAX(MAX(deal._fivetran_synced)) OVER()::TIMESTAMP AS last_updated	
FROM hubs.deal AS deal
INNER JOIN hubs.deal_company AS dc
	ON deal.deal_id = dc.deal_id
	AND dc.type_id = 5 -- primary company only
INNER JOIN hubs.company AS com
	ON dc.company_id = com.id
LEFT JOIN hubs.vw_child_to_parent AS cp
	ON com.id = cp.child_id
INNER JOIN hubs.deal_pipeline_stage AS stage
	ON deal.deal_pipeline_stage_id = stage.stage_id
LEFT JOIN hubs.property_option AS opt
	ON com.property_sector_grouped_ = opt.value
	AND opt.property_id = 'LvhF5AouIjxudPghzI6sPeTQQis=' -- property_id for sector_grouped_
	AND opt.label NOT IN (
		'Other', 
		'Tier 2 - Industrials/CPG/Retail', 
		'Tier 3 - TMT/Fashion/Textile/Luxury', 
		'Tier 4 - Trans/Log/R.estate/Cons/Hospitality', 
		''
	)
LEFT JOIN hubs.property_option AS ind_opt
	ON com.property_industry = ind_opt.value
	AND ind_opt.property_id = 'MNb4LKB3CdQneBw6/CdXw5gj0o0=' -- property_id for industry
WHERE
	1 = 1
	AND deal.deal_pipeline_id = 19800993 -- id for sales_pipeline_v2
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15