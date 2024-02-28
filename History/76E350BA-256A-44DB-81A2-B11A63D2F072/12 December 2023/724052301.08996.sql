SELECT
	u.email,
	g.client_id	
FROM auth0.users AS u
INNER JOIN auth0.grants AS g
	ON u.id = g.user_id