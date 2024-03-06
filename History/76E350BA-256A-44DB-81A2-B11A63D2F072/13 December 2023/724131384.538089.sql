SELECT DISTINCT 
	g.client_id,
	gs.scope
FROM auth0.grants AS g
INNER JOIN auth0.grant_scope AS gs
	ON g.id = gs.grant_id