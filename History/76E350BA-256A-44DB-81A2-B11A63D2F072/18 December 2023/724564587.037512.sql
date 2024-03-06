SELECT
	hist.time,
	hist.value AS assignee_id,
	u.name AS assignee_name
FROM jra.issue_field_history AS hist
INNER JOIN jra.issue AS i
	ON hist.issue_id = i.id
	AND i.key = 'REDUCE-1339'
LEFT JOIN jra.user AS u
	ON hist.value = u.id
WHERE
	1 = 1
	AND hist.field_id = 'assignee'
ORDER BY hist.time DESC