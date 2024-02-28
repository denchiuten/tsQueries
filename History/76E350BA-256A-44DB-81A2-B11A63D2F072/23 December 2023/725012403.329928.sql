SELECT
	u.id,
	u.email
FROM auth0.users AS u
INNER JOIN auth0.user_metadata AS m
	ON u.id = '''' || m.user_detail_id
	AND m."name" = 'organization'