SELECT
	all_dates.obs_date,
	deal.property_dealname AS deal,
	com.property_name AS child_name,
	cp.parent_name AS parent_name.
	com.property_country_menu_ AS country,
	com.property_sector_grouped_ AS sector,
	owner.first_name || ' ' || owner.last_name AS owner,
	DATE_TRUNC('month', deal.property_hs_closed_won_date)::DATE AS closed_date,
	DATE_TRUNC('month', deal.property_end_date)::DATE AS end_date, 
	SUM(deal.property_arr_usd_) AS arr,
	SUM(deal.property_hs_acv) AS acv,
	SUM(deal.property_hs_tcv) AS tcv,
	MAX(MAX(deal._fivetran_synced)) OVER()::TIMESTAMP AS last_updated
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
GROUP BY 1,2,3,4,5,6,7,8,9