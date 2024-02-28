SELECT	
	hist.issue_id,
	hist.value AS assignee,
	DENSE_RANK() OVER (
		ORDER BY hist.time DESC,
		PARTITION BY hist.issue_id
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
) AS set
	ON hist.issue_id = set.issue_id
WHERE
	1 = 1
	AND hist.field_id = 'assignee'
GROUP BY 1,2
ORDER BY 1,3