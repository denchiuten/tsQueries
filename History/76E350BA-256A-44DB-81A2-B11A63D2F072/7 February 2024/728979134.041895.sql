SELECT 
	map.auth0_id,
	org.name,
	com.property_name
	
	
FROM plumbing.auth0_to_hubspot_company AS map
LEFT JOIN auth0.organization AS org
	ON map.auth0_id = org.id
LEFT JOIN hubs.company AS com
	ON TO_CHAR(map.company_id) = TO_CHAR(com.property_hs_object_id)