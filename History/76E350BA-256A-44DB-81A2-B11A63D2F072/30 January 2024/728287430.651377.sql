SELECT 
	email,
	is_active
FROM hubs.owner
WHERE 
	LOWER(email) NOT LIKE '%@terrascope.com'
	AND is_active IS TRUE
ORDER BY 1