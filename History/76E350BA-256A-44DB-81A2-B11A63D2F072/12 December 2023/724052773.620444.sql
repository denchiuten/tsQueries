SELECT
	REPLACE(u.email, '''', '') AS email,
	REPLACE(u.id, '''', '') AS user_id,
	g.client_id,
	cg.audience
FROM auth0.users AS u
INNER JOIN auth0.grants AS g
	ON u.id = '''' || g.user_id
LEFT JOIN auth0.client_grant AS cg
	ON g.client_id = cg.client_id
-- WHERE 
-- 	LOWER(u.email) NOT LIKE '%@terrascope.com'
ORDER BY 1