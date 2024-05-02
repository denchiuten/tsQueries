SELECT 
	id, name 
FROM auth0.organization AS a
WHERE 
	a.id NOT IN (SELECT auth0_id FROM plumbing.auth0_to_hubspot_company)
	AND name NOT LIKE '%demo%'
	AND name NOT LIKE '%terrascope%'
	AND name NOT LIKE '%poc%'
	AND name NOT LIKE '%prod%'
	AND name NOT LIKE '%bcgdv%'
	AND name NOT IN ('food-and-agri', 'pcf', 'cp-foods')