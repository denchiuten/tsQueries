SELECT *
FROM jra.vw_latest_issue_multiselect_value
WHERE 
	1 = 1
	AND field_id = 'labels'
	AND LOWER(value) LIKE '%test%'
LIMIT 1000