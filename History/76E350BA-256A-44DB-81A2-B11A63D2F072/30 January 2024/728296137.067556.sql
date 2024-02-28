SELECT 
	email,
	last_name,
	first_name,
	is_active
FROM hubs.owner
WHERE 
	1 = 1
	AND LOWER(email) LIKE '%@nbh.com'
	AND is_active IS TRUE
ORDER BY 1