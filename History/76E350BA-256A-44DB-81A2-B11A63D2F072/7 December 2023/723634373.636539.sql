SELECT 
	p."name",
	t.*

FROM harvest.time_entry AS t
INNER JOIN harvest.project AS p
	ON t.project_id = p.id
WHERE t.id = 2247898047