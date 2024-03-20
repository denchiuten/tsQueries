SELECT
	i.identifier AS issue_key,
	i.url,
	i.title,
	u.name AS assignee,
	sl.id AS slack_user_id,
	l.name AS label_name
FROM linear.issue AS i
INNER JOIN linear.issue_label AS il
	ON i.id = il.issue_id
	AND il._fivetran_deleted IS FALSE
INNER JOIN linear.label AS l
	ON il.label_id = l.id
	AND l._fivetran_deleted IS FALSE
	AND l.parent_id = 'cd63ea41-6373-4e5c-8132-6a41d06b1d89'
INNER JOIN linear.workflow_state AS ws
	ON i.state_id = ws.id
	AND ws.name = 'Done'
INNER JOIN linear.users AS u
	ON i.assignee_id = u.id
	AND u._fivetran_deleted IS FALSE
INNER JOIN slack.users AS sl
	ON LOWER(u.email) = LOWER(sl.profile_email)
	AND sl._fivetran_deleted IS FALSE
	AND sl.deleted IS FALSE