SELECT 	field.issue_id,
	field.value,
	i.key,
	i.status_category_changed,
	s.nameFROM jra.vw_latest_issue_field_value AS field
INNER JOIN jra.status AS s
	ON field.value = s.id
INNER JOIN jra.issue AS i
	ON field.issue_id = i.idWHERE	1 = 1		AND field.field_id = 'status'	AND field.time::DATE >= '2023-12-14'	AND field.author_id = '63c50741cd6a09abe71e007c' -- Bryan