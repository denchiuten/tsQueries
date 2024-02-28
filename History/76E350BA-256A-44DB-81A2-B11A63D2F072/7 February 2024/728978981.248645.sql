SELECT 
	map.auth0_id,
	org.name
	
FROM plumbing.auth0_to_hubspot_company AS map
LEFT JOIN auth0.organization AS org
	ON map.auth0_id = org.id