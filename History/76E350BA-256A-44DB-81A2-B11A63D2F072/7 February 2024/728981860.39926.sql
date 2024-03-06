SELECT 
	map.auth0_id,
	org.name,
	map.company_id,
	com.property_name
	
	
FROM plumbing.auth0_to_hubspot_company AS map
LEFT JOIN auth0.organization AS org
	ON map.auth0_id = org.id
LEFT JOIN hubs.company AS com
	ON map.company_id = com.property_hs_object_id