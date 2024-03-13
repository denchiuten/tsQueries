SELECT 
	field.issue_id,
	u.id
FROM jra.vw_latest_issue_field_value AS field
INNER JOIN jra.issue AS i
	ON field.issue_id = i.id
INNER JOIN jra.user AS u
	ON field.author_id = u.id
	AND u.name = 'Bryan Mathews'
WHERE
	1 = 1	
	AND field.field_id = 'assignee'
	AND field.value IS NULL
	AND field.time::DATE = '2023-12-14'