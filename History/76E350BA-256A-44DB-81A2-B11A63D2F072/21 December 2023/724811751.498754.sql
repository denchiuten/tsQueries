SELECT DISTINCT
	t.name,
	t.id
FROM jra.issue AS i
INNER JOIN jra.issue_type AS t
	ON i.issue_type = t.id
INNER JOIN jra.epic AS e
	AND i.key = e.key