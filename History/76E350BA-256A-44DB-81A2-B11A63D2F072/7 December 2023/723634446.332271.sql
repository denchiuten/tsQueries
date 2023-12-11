SELECT 
	p."name" AS project,
-- 	u.first_name,
	t.*

FROM harvest.time_entry AS t
INNER JOIN harvest.project AS p
	ON t.project_id = p.id
-- INNER JOIN harvest.users AS u
-- 	ON t.user_id = u.id
WHERE t.id = 2247898047