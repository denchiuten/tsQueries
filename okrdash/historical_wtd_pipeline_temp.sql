SELECT DISTINCT
	d.datemonth,
	sh.deal_id,
	sh.stage_id,
	sh.stage_name,
	dps.probability,
	COALESCE(CASE WHEN acv.field_name = 'acv_usd' THEN acv.value::FLOAT ELSE 0 END,0) AS acv_usd,
	COALESCE(CASE WHEN acv.field_name = 'hs_acv' THEN acv.value::FLOAT ELSE 0 END,0) AS acv_fx
FROM (
	SELECT DISTINCT LAST_DAY(date) AS datemonth
	FROM plumbing.dates
	WHERE date <= CURRENT_DATE
) AS d
INNER JOIN hubs.vw_deal_stage_history AS sh
	ON d.datemonth BETWEEN sh.valid_from AND sh.valid_to 
LEFT JOIN hubs.vw_deal_property_history AS acv
	ON sh.deal_id = acv.deal_id
	AND acv.field_name IN ('acv_usd', 'hs_acv')
	AND d.datemonth BETWEEN acv.valid_from AND acv.valid_to

INNER JOIN hubs.deal_pipeline_stage AS dps
	ON sh.stage_id = dps.stage_id
	AND dps._fivetran_deleted IS FALSE
ORDER BY 2,1;

-- SELECT DISTINCT stage_name FROM hubs.vw_deal_stage_history

-- SELECT DISTINCT field_name FROM hubs.vw_deal_property_history ORDER BY 1