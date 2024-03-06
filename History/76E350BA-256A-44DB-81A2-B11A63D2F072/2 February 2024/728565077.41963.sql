SELECT 
	i.key
FROM jra.issue AS i
INNER JOIN jra.issue_type AS it
	ON i.issue_type = it.id
	AND it.name = 'Test'
WHERE
	1 = 1
	AND i._fivetran_deleted IS FALSE