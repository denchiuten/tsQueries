SELECT
	COUNT(u.id), 
	SUM(CASE WHEN m.user_detail_id IS NOT NULL THEN 1 ELSE 0 END)
FROM auth0.users AS u
LEFT JOIN auth0.user_metadata AS m
	ON u.id = '''' || m.user_detail_id
	AND m."name" = 'organization'