SELECT
	l.date::DATE AS date,
	COUNT(DISTINCT hu.email) AS n
FROM auth0.logs AS l
INNER JOIN auth0.users AS au
	ON l.user_id = REPLACE(au.id, '''', '')
INNER JOIN hubs.users AS hu
	ON LOWER(au.email) = LOWER(hu.email)
GROUP BY 1