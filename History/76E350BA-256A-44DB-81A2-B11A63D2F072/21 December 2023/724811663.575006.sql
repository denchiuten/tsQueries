SELECT t."name", t.description, t.id
FROM jra.issue AS i
INNER JOIN jra.issue_type AS t
	ON i.issue_type = t.id
WHERE i."key" = 'DEVSECOPS-12';