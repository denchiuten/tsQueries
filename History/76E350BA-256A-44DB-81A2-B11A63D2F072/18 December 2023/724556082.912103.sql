SELECT 
	u.name,
	field.issue_id,
	i.key,
	field.time::DATE AS updated
FROM jra.issue_field_history AS field
INNER JOIN jra.issue AS i
	ON field.issue_id = i.id
LEFT JOIN jra.user AS u
	ON field.author_id = u.id
WHERE
	1 = 1	
	AND field.field_id = 'assignee'
	AND field.value IS NULL
	AND i.key = 'CUSIMP-3751'
ORDER BY 1