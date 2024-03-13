SELECT DISTINCT
	cc.company_id,
	com.property_name AS company_name,
	org.name,
	map.company_id,
	map.auth0_id
FROM auth0.logs AS l
INNER JOIN auth0.users AS au
	ON l.user_id = REPLACE(au.id, '''', '')
INNER JOIN hubs.contact AS con
	ON LOWER(au.email) = LOWER(con.property_email)
INNER JOIN hubs.contact_company AS cc
	ON con.id = cc.contact_id
	AND cc.type_id = 1
	AND cc.company_id <> 9244595755
LEFT JOIN plumbing.auth0_to_hubspot_company AS map
	ON cc.company_id = map.company_id
LEFT JOIN hubs.company AS com
	ON map.company_id = com.id
LEFT JOIN auth0.organization AS org
	ON map.auth0_id = org.id