SELECT
	map.auth0_id,
	COUNT(*)
FROM plumbing.auth0_to_hubspot_company AS map
GROUP BY 1