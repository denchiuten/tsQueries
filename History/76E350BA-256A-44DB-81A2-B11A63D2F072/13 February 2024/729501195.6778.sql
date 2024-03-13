SELECT DISTINCT
	l.date::DATE AS date,
	COALESCE(cp.parent_name, cp.child_name) AS company_name,
	COALESCE(cp.parent_id, cp.child_id) AS company_id
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
LEFT JOIN hubs.vw_child_to_parent AS cp
	ON com.id = cp.child_id
ORDER BY 1