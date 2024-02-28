SELECT
	child.id AS child_id,
	child.parent_id As parent_id,
	child.key AS child_key,
	parent.key AS parent_key
FROM jra.issue AS child
INNER JOIN jra.issue AS parent
	ON child.parent_id = parent.id
	AND parent._fivetran_deleted IS FALSE
INNER JOIN jra.issue_type AS parent_type
	ON parent.issue_type = parent_type.id
	AND parent_type.name = 'Epic'
WHERE
	1 = 1
	AND i._fivetran_deleted IS FALSE
	AND i.key = 'MEASURE-3504'