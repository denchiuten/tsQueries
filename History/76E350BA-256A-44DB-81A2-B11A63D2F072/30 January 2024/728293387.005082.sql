SELECT 
	email,
	last_name,
	first_name
FROM hubs.owner
WHERE 
	1 = 1
-- 	AND LOWER(email) LIKE '%@terrascope.com'
	AND is_active IS TRUE
ORDER BY 1