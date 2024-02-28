SELECT
	i.identifier AS issue_key,
	i.title,
	ws.name AS status,
	i.completed_at::DATE AS completed_at,
	i.created_at::DATE AS created_at
FROM linear.issue AS i
INNER JOIN linear.issue_label AS map
	ON i.id = map.issue_id
	AND map.label_id = 'd55f5bdc-3991-46d0-ab8d-f7140c595202'
	AND map._fivetran_deleted IS FALSE
INNER JOIN linear.workflow_state AS ws
	ON i.state_id = ws.id
WHERE
	1 = 1
	AND i._fivetran_deleted IS FALSE