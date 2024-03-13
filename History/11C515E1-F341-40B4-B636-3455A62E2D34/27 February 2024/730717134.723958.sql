SELECT
	i.id AS issue_id,
	i.identifier AS issue_key,
	h.to_priority
FROM linear.issue_history AS h
INNER JOIN linear.issue AS i
	ON h.issue_id = i.id
	AND i._fivetran_deleted IS FALSE
INNER JOIN linear.team AS t
	ON i.team_id = t.id
	AND t.key = 'PTINC'
	AND t._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND h._fivetran_deleted IS FALSE
	AND h.from_priority <> h.to_priority
	AND h.to_priority IS NOT NULL OR h.from_priority IS NOT NULL