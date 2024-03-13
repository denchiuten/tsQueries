SELECT 
	name,
	id
FROM auth0.organization
WHERE
	1 = 1
	AND name NOT LIKE '%terrascope%'
	AND name NOT LIKE '%sandbox%'
	AND name NOT LIKE '%bcgdv%'
	AND name NOT IN ('pcf', 'food-and-agri',"poc-ts-mt");