SELECT * 
FROM jra.issue_multiselect_history As f
INNER JOIN jra.issue AS i
	ON f.issue_id = i.id
	AND i.key = 'MEASURE-3179'
WHERE field_id = 'customfield_10020'