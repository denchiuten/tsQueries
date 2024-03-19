SELECT 
	DATE_TRUNC('month', e.event_time)::DATE AS datemonth,
	COUNT(DISTINCT map.company_id) AS n_companies
FROM fullstory_o_1jfe7s_na1.events AS e
INNER JOIN plumbing.auth0_to_hubspot_company AS map
	ON JSON_EXTRACT_PATH_TEXT(e.event_properties::VARCHAR, 'user_properties', 'organizationId_str') = map.auth0_id

WHERE
	JSON_EXTRACT_PATH_TEXT(e.event_properties::VARCHAR, 'user_properties', 'organizationId_str') <> ''
GROUP BY 1
ORDER BY 1

SELECT
	f.date,
	SUM(f.value) AS amount
FROM finance.actuals AS f
WHERE
	1 = 1
	AND f.close_date = (SELECT MAX(close_date) FROM finance.actuals)
	AND f.date <= f.close_date
	AND f.lt_ppt_mapping = 'Cloud Cost - External'
GROUP BY 1 
ORDER BY 1