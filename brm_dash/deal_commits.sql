SELECT
	deal._fivetran_synced AS last_updated,
	stage.label AS stage,
	o.first_name || ' ' || o.last_name AS owner,
	com.property_country_menu_ AS country,
	COALESCE(opt.label, '*Sector Missing') AS sector,
	deal.deal_id,
	deal.property_dealname AS deal_name,
	deal.property_dealtype AS deal_type,
	com.id AS company_id,
	com.property_name AS company,
	deal.property_incremental_acv_usd_ AS net_new_acv,
	deal.property_acv_usd AS ACV,
	deal.property_amount_in_home_currency AS TCV,
	deal.property_annual_recurring_revenue_usd_ AS ARR,
	deal.property_closedate::DATE AS close_date,
	deal.property_commencement_date::DATE AS commencement_date,
	deal.property_end_date::DATE AS end_date,
	COALESCE(DATEDIFF('months', deal.property_commencement_date::DATE, deal.property_end_date::DATE), deal.property_contract_term_in_years_) AS term_months	
FROM hubs.deal AS deal
INNER JOIN hubs.deal_pipeline_stage AS stage
	ON deal.deal_pipeline_stage_id = stage.stage_id
	AND stage.label <> '#10 Closed lost'
INNER JOIN hubs.deal_company AS dc
	ON deal.deal_id = dc.deal_id
	AND dc.type_id = 5 -- primary company association type
INNER JOIN hubs.company AS com
	ON dc.company_id = com.id
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
LEFT JOIN hubs.owner AS o
	ON deal.owner_id = o.owner_id
WHERE
	1 = 1
	AND deal._fivetran_deleted IS FALSE
	AND deal.property_hs_manual_forecast_category = 'COMMIT'
	AND deal.deal_pipeline_id = 19800993