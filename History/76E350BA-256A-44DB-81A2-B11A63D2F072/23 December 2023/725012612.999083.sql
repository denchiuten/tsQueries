-- SELECT
-- 	u.id,
-- 	u.email,
-- 	m.*
-- FROM auth0.users AS u
-- INNER JOIN auth0.user_metadata AS m
-- 	ON u.id = '''' || m.user_detail_id
-- 	AND m."name" = 'organization';

SELECT 
	l.*
FROM auth0.logs AS l
INNER JOIN auth0.users AS u
	ON '''' || l.user_id = u.id
LIMIT 1000;