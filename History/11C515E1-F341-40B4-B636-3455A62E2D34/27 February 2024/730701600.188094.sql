SELECT
	i.id AS issue_id,
	i.identifier AS issue_key,
	release_label.label_id AS release_version_label_id,
	parent_label.name AS release_version_label_name
FROM linear.issue_label AS il
INNER JOIN linear.issue AS i
	ON il.issue_id = i.id
	AND i._fivetran_deleted IS FALSE

-- pull only issues marked as done
INNER JOIN linear.workflow_state AS ws
	ON i.state_id = ws.id
	AND ws.name = 'Done'
	AND ws._fivetran_deleted IS FALSE
INNER JOIN linear.issue_label AS release_label
	ON i.id = release_label.issue_id
	AND release_label._fivetran_deleted IS FALSE
INNER JOIN linear.label AS parent_label
	ON release_label.label_id = parent_label.id
	AND parent_label._fivetran_deleted IS FALSE
	
	-- filter only for issues with parent label in the Release Version label group
	AND parent_label.parent_id = 'd7a0ab5a-9ffc-4da0-beba-ed5d2d542dc7'
WHERE
	1 = 1
	AND il._fivetran_deleted IS FALSE
	-- label_id for release-ticket label
	AND il.label_id = '64064c80-0193-402f-a943-4d891da828a6'
	AND YEAR(i.completed_at) = 2024