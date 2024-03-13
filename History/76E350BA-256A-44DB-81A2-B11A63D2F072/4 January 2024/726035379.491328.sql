SELECT
	hist.issue_id,
	to_assignee_id		
FROM linear.issue_history AS hist
INNER JOIN linear.issue AS i
	ON hist.issue_id = i.id
	AND i._fivetran_deleted IS FALSE
INNER JOIN linear.project AS p
	ON i.project_id = p.id
	AND p.key = 'CS'
WHERE
	1 = 1
	AND hist._fivetran_deleted IS FALSE
	AND hist.from_assignee_id <> hist.to_assignee_id
	AND hist.to_assignee_id IS NOT NULL