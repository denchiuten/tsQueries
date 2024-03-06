SELECT 
	email,
	last_name,
	first_name
FROM hubs.owner
WHERE 
	LOWER(email) NOT LIKE '%@terrascope.com'
	AND is_active IS TRUE
ORDER BY 1