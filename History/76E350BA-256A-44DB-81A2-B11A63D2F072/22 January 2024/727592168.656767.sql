SELECT DISTINCT
	com.property_sector_grouped_ AS sector
FROM hubs.deal AS deal
INNER JOIN hubs.deal_company AS dc
	ON deal.deal_id = dc.deal_id
	AND dc.type_id = 5 -- primary company only
INNER JOIN hubs.owner AS owner
	ON deal.owner_id = owner.owner_id
INNER JOIN hubs.company AS com
	ON dc.company_id = com.id
LEFT JOIN hubs.vw_child_to_parent AS cp
	ON com.id = cp.child_id 
INNER JOIN hubs.deal_pipeline_stage AS stage
	ON deal.deal_pipeline_stage_id = stage.stage_id
	AND stage.label = '#09 WON'
INNER JOIN (
	SELECT DISTINCT DATE_TRUNC('month', date)::DATE AS obs_date
	FROM plumbing.dates
) AS all_dates
	ON all_dates.obs_date BETWEEN DATE_TRUNC('month', deal.property_hs_closed_won_date) AND DATE_TRUNC('month', deal.property_end_date)
WHERE
	1 = 1
	AND deal.property_arr_usd_ + deal.property_hs_acv + deal.property_hs_tcv > 0