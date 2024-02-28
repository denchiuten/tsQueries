SELECT
	c.id,
	COUNT(DISTINCT cg.id) AS n
FROM auth0.client AS c
LEFT JOIN auth0.client_grant AS cg
	ON c.id = cg.client_id
GROUP BY 1