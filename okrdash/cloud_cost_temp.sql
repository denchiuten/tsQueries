SELECT
	f.date,
	fs.n_data_planes,
	SUM(f.value) AS amount
-- 	AVG(fs.n_data_planes) AS n_data_planes
FROM finance.actuals AS f
INNER JOIN (
	SELECT 
		LAST_DAY(e.event_time::DATE) AS date,
		COUNT(DISTINCT map.company_id) AS n_data_planes
	FROM fullstory_o_1jfe7s_na1.events AS e
	INNER JOIN plumbing.auth0_to_hubspot_company AS map
		ON JSON_EXTRACT_PATH_TEXT(e.event_properties::VARCHAR, 'user_properties', 'organizationId_str') = map.auth0_id
	WHERE
		JSON_EXTRACT_PATH_TEXT(e.event_properties::VARCHAR, 'user_properties', 'organizationId_str') <> ''
	GROUP BY 1
) AS fs
	ON f.date = fs.date
WHERE
	1 = 1
	AND f.close_date = (SELECT MAX(close_date) FROM finance.actuals)
	AND f.date <= f.close_date
	AND f.lt_ppt_mapping = 'Cloud Cost - External'
	AND f.value > 0
GROUP BY 1,2
ORDER BY 1


