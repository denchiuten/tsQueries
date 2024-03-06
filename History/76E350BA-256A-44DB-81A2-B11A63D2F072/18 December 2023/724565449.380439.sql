SELECT 
		field.issue_id
	FROM jra.vw_latest_issue_field_value AS field
	WHERE
		1 = 1	
		AND field.field_id = 'assignee'
		AND field.value IS NULL
		AND field.time::DATE >= '2023-12-14'
		AND field.author_id = '63c50741cd6a09abe71e007c' -- Bryan