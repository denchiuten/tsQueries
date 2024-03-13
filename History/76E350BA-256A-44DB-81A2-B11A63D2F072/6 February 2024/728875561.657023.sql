SELECT
	map.company_id,
	COUNT(*)
FROM plumbing.auth0_to_hubspot_company AS map
GROUP BY 1
ORDER BY  2 DESC