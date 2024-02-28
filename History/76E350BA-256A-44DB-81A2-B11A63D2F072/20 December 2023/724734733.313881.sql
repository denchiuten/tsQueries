SELECT 
	c.id AS child_id,
	c.key AS child_key,
	c.parent_id AS pid,
	p.id AS parent_id,
	p.key AS parent_key
FROM jra.issue AS c
LEFT JOIN jra.issue AS p
	ON c.parent_id = p.id
WHERE c.id = 23130