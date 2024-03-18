SELECT 
	field.value,
	i.key,
	i.status_category_changed,
	s.name
INNER JOIN jra.status AS s
	ON field.value = s.id
INNER JOIN jra.issue AS i
	ON field.issue_id = i.id