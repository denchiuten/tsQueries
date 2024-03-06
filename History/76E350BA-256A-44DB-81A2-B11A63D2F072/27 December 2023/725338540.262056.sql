SELECT
	i.key
FROM jra.issue AS i
INNER JOIN jra.project AS p
	ON i.project = p.id
	AND p.key = 'DTS'
INNER JOIN jra.user AS u
	ON i.assignee = u.id
WHERE u.email <> 'bryannoel.mathews@terrascope.com'
GROUP BY 1,2