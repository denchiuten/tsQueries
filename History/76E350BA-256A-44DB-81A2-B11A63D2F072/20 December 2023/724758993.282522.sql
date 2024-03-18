SELECT
	COALESCE(deal.property_arr_usd_, 0) AS arr,
	COALESCE(deal.property_hs_acv, 0) AS acv
	AND stage.label NOT IN ('#10 Closed lost', '#11 Backburner')