SELECT
	imp._fivetran_synced AS data_up_to,
	com.property_name AS company_name,
	deal.property_dealname AS deal_name,
	deal.deal_id AS deal_id,
	deal.property_acv_usd AS acv,
	deal.property_commencement_date::DATE AS commencement_date,
	imp.property_measurement_year AS measurement_year,
	imp.property_milestone_date AS kickoff_date,
	imp.property_shareback_date AS shareback_date,
	imp.id AS imp_id,
	COALESCE(opt.label, '*Sector Missing') AS sector
FROM hubs.implementation_dates AS imp
INNER JOIN hubs.implementation_dates_to_deal AS idd
	ON imp.id = idd.from_id
INNER JOIN hubs.deal AS deal
	ON idd.to_id = deal.deal_id
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
WHERE
	1 = 1
	AND imp._fivetran_deleted IS FALSE
	AND imp.property_milestone_date IS NOT NULL
	AND imp.property_shareback_date IS NOT NULL
	AND imp.property_shareback_date <= CURRENT_DATE