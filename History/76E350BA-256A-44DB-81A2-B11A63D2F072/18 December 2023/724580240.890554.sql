SELECT 	field.issue_id,
	opt.nameFROM jra.vw_latest_issue_field_value AS field
INNER JOIN jra.field_option As opt
	ON field.value = opt.idWHERE	1 = 1		AND field.field_id = 'status'	AND field.time::DATE >= '2023-12-14'	AND field.author_id = '63c50741cd6a09abe71e007c' -- Bryan