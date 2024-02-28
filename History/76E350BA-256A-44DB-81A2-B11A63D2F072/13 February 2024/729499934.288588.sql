SELECT
	l.date::DATE AS date,
	COUNT(DISTINCT con.email) AS n
FROM auth0.logs AS l
INNER JOIN auth0.users AS au
	ON l.user_id = REPLACE(au.id, '''', '')
INNER JOIN hubs.contact AS con
	ON LOWER(au.email) = LOWER(con.email)
INNER JOIN 
GROUP BY 1