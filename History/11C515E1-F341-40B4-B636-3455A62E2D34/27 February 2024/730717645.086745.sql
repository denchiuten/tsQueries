SELECT
	i.id AS issue_id,
	i.created_at,
	i.identifier AS issue_key,
	i.parent_id AS parent_issue_id,
	parent.created_at AS parent_created_at,
	h.to_priority
FROM linear.issue_history AS h
INNER JOIN linear.issue AS i
	ON h.issue_id = i.id
	AND i._fivetran_deleted IS FALSE
LEFT JOIN linear.issue AS parent
	ON i.parent_id = parent.id
	AND parent._fivetran_deleted IS FALSE
INNER JOIN linear.team AS t
	ON i.team_id = t.id
	AND t.key = 'PTINC'
	AND t._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND h._fivetran_deleted IS FALSE
	AND h.from_priority <> h.to_priority