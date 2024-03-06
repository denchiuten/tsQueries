SELECT
p.*,
u.email
FROM linear.project AS p
INNER JOIN linear.users AS u
	ON p.creator_id = u.id
-- 	AND u.email = 'etienne.schoettel@terrascope.com'