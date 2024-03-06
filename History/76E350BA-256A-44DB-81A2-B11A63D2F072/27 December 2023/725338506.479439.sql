SELECT
	u.email,
	u.id,
	COUNT(i.id)
FROM jra.issue AS i
INNER JOIN jra.project AS p
	ON i.project = p.id
	AND p.key = 'DTS'
INNER JOIN jra.user AS u
	ON i.assignee = u.id
GROUP BY 1,2