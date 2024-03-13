SELECT
	i.key, 
	s.name
FROM jra.issue AS i
INNER JOIN jra.project AS p
	ON i.project = p.id
	AND p.key = 'DTS'
INNER JOIN jra.user AS u
	ON i.assignee = u.id
INNER JOIN jra.status AS s
	ON i.status = s.id
WHERE u.email <> 'bryannoel.mathews@terrascope.com'