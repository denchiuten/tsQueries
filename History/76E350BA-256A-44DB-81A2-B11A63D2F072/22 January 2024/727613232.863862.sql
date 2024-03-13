SELECT
	i.identifier AS key,
	i.title,
	u.name AS current_assignee,
	u_first.name AS original_assignee,
	s.name AS current_status,
	s_first.name AS original_status
FROM linear.issue_history AS h
INNER JOIN linear.issue AS i
	ON h.issue_id = i.id
	AND i._fivetran_deleted IS FALSE
INNER JOIN linear.issue_label AS il
	ON i.id = il.issue_id
	AND il.label_id = '049096e6-b6a2-4f56-b9ea-e5c643e9e279'
INNER JOIN linear.workflow_state AS s
	ON i.state_id = s.id
	AND s._fivetran_deleted IS FALSE
INNER JOIN linear.workflow_state AS s_first
	ON h.from_state_id = s_first.id
LEFT JOIN linear.users AS u
	ON i.assignee_id = u.id
	AND u._fivetran_deleted IS FALSE
LEFT JOIN linear.users AS u_first
	ON h.from_assignee_id = u_first.id
	AND u_first._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND h._fivetran_deleted IS FALSE
	AND (h.from_assignee_id <> h.to_assignee_id OR h.from_state_id <> h.to_state_id)