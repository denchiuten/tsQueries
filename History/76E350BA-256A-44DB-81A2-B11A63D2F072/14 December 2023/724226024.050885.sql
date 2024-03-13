SELECT 
	name,
	id
FROM slack.users
WHERE is_bot = TRUE
ORDER BY 1