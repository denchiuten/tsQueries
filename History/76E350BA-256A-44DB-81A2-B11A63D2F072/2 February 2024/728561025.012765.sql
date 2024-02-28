SELECT

	SUM(deal.property_hs_arr * DATEDIFF('months', deal.property_commencement_date::DATE, deal.property_end_date::DATE)) /  SUM(deal.property_hs_arr) AS wtd_duration
FROM hubs.deal AS deal
INNER JOIN hubs.deal_company AS dc
	ON deal.deal_id = dc.deal_id
	AND dc.type_id = 5 -- primary company only
INNER JOIN hubs.company AS com
	ON dc.company_id = com.id
INNER JOIN hubs.deal_pipeline_stage AS stage
	ON deal.deal_pipeline_stage_id = stage.stage_id
	AND stage.label = '#09 WON'
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
	AND deal.property_hs_arr > 0