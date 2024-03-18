SELECT 
	field.value,
	i.key,
	s.name
INNER JOIN jra.status AS s
	ON field.value = s.id
INNER JOIN jra.issue AS i
	ON field.issue_id = i.id