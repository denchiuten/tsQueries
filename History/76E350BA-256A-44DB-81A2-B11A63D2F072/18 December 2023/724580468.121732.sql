SELECT 
	field.value,
	s.name
INNER JOIN jra.status AS s
	ON field.value = s.id