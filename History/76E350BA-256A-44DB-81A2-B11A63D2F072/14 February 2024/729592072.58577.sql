SELECT
		all_dates.obs_date,
		deal.deal_id,
		deal.property_dealname AS deal,
		deal.property_hs_acv AS acv,
		com.property_name AS child_name,
		com.property_country_menu_ AS country,
		DATE_TRUNC('week', deal.property_hs_closed_won_date)::DATE AS closed_date,
		DATE_TRUNC('week', deal.property_end_date)::DATE AS end_date, 
		deal.property_closed_won_reason_checkbox AS closed_won_reason,
		deal.property_arr_usd_ AS arr,
		deal.property_hs_tcv AS tcv
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
		SELECT DISTINCT d.week_ending_date AS obs_date
		FROM plumbing.dates AS d
		WHERE d.date <= CURRENT_DATE
	) AS all_dates
		ON all_dates.obs_date BETWEEN DATE_TRUNC('week', deal.property_hs_closed_won_date) AND DATE_TRUNC('week', deal.property_end_date)
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
		AND deal.property_arr_usd_ + deal.property_hs_acv + deal.property_hs_tcv > 0
		AND deal._fivetran_deleted IS FALSE
		AND all_dates.obs_date = '2024-02-17'