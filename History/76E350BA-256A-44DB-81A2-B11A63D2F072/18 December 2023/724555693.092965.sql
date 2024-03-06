SELECT 
	field.value
FROM jra.vw_latest_issue_field_value AS field
WHERE
	1 = 1	
	AND field.field_id = 'assigned'