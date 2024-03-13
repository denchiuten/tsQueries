SELECT
	i.identifier AS key,
	i.title,
	t.name AS team_name,
	t.key AS team_key,
	i.url,
	u.name AS current_assignee,
	s.name AS current_status
FROM linear.issue AS i
INNER JOIN linear.issue_label AS il
	ON i.id = il.issue_id
	AND il.label_id = '049096e6-b6a2-4f56-b9ea-e5c643e9e279'
INNER JOIN linear.workflow_state AS s
	ON i.state_id = s.id
	AND s._fivetran_deleted IS FALSE
LEFT JOIN linear.users AS u
	ON i.assignee_id = u.id
	AND u._fivetran_deleted IS FALSE
INNER JOIN linear.team AS t
	ON i.team_id = t.id
WHERE
	1 = 1
	AND i._fivetran_deleted IS FALSE