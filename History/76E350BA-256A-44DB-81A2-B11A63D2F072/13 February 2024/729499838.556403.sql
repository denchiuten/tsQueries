SELECT
	l.date::DATE) AS date,
	COUNT(DISTINCT u.email
FROM auth0.logs AS l
INNER JOIN auth0.users AS u
	ON l.user_id = REPLACE(u.id, '''', '')
GROUP BY 1