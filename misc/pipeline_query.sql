SELECT
	stage.label AS stage,
	COALESCE(deal.property_arr_usd_, 0) AS arr,
	COALESCE(deal.property_hs_acv, 0) AS acv
	AND stage.label NOT IN ('#10 Closed lost', '#11 Backburner')
	AND (deal.property_end_date IS NULL OR deal.property_end_date >= CURRENT_DATE)
ORDER BY 
	2,8 DESC