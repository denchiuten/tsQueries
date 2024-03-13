SELECT
	COUNT(u.id), 
	COUNT(DISTINCT u.id)
FROM auth0.users AS u
LEFT JOIN auth0.user_metadata AS m
	ON u.id = '''' || m.user_detail_id