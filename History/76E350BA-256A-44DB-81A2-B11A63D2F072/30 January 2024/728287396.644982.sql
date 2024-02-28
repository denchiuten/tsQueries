SELECT 
	email,
	is_active
FROM hubs.owner
WHERE LOWER(email) NOT LIKE '%@terrascope.com'
ORDER BY 1