SELECT
	i.identifier AS key,
	i.title,
	t.name AS team_name,
	t.key AS team_key,
	i.url,
	COALESCE(u.name, 'Unassigned') AS current_assignee,
	COALESCE(u_first.name, 'Unassigned') AS original_assignee,
	slack_u_first.slack_user_id AS original_assignee_slack_id,
	slack_u.slack_user_id AS current_assignee_slack_id,
	s.name AS current_status,
	s_first.name AS original_status
FROM linear.issue_history AS h
INNER JOIN linear.issue AS i
	ON h.issue_id = i.id
	AND i._fivetran_deleted IS FALSE
INNER JOIN linear.issue_label AS il
	ON i.id = il.issue_id
	AND il.label_id = '049096e6-b6a2-4f56-b9ea-e5c643e9e279'
LEFT JOIN linear.workflow_state AS s
	ON i.state_id = s.id
	AND s._fivetran_deleted IS FALSE
LEFT JOIN linear.workflow_state AS s_first
	ON h.from_state_id = s_first.id
LEFT JOIN linear.users AS u
	ON i.assignee_id = u.id
	AND u._fivetran_deleted IS FALSE
LEFT JOIN linear.users AS u_first
	ON h.from_assignee_id = u_first.id
	AND u_first._fivetran_deleted IS FALSE
LEFT JOIN plumbing.vw_user_id_lookup AS slack_u
	ON LOWER(u.email) = LOWER(slack_u.email)
LEFT JOIN plumbing.vw_user_id_lookup AS slack_u_first
	ON LOWER(u_first.email) = LOWER(slack_u_first.email)
INNER JOIN linear.team AS t
	ON i.team_id = t.id
WHERE
	1 = 1
	AND h._fivetran_deleted IS FALSE
	AND (h.from_assignee_id <> h.to_assignee_id OR h.from_state_id <> h.to_state_id)