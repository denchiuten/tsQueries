SELECT	
	hist.issue_id,
	hist.value AS assignee_id,
	u.name AS assignee_name,
	hist.time,
	DENSE_RANK() OVER (
		PARTITION BY hist.issue_id
		ORDER BY hist.time DESC
	) AS rank
FROM jra.issue_field_history AS hist
INNER JOIN(
	SELECT 
		field.issue_id
	FROM jra.vw_latest_issue_field_value AS field
	WHERE
		1 = 1	
		AND field.field_id = 'assignee'
		AND field.value IS NULL
		AND field.time::DATE = '2023-12-14'
		AND field.author_id = '63c50741cd6a09abe71e007c' -- Bryan
) AS latest
	ON hist.issue_id = latest.issue_id
LEFT JOIN jra.user AS u
	ON hist.value = u.id
WHERE
	1 = 1
	AND hist.field_id = 'assignee'
ORDER BY 1,5