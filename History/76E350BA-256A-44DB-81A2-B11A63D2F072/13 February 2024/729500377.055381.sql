SELECT DISTINCT
	com.property_name
FROM auth0.logs AS l
INNER JOIN auth0.users AS au
	ON l.user_id = REPLACE(au.id, '''', '')
INNER JOIN hubs.contact AS con
	ON LOWER(au.email) = LOWER(con.property_email)
INNER JOIN hubs.contact_company AS cc
	ON con.id = cc.contact_id
	AND cc.type_id = 1
	AND cc.company_id <> 9244595755
INNER JOIN hubs.company AS com
	ON cc.company_id = com.id