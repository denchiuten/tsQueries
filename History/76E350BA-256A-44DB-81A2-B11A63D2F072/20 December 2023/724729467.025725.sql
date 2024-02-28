SELECT 
	child.key AS child_key,
	parent.key AS parent_key,
	l.*
FROM jra.issue AS child
INNER JOIN jra.issue_link AS l
	ON child.id = l.issue_id
INNER JOIN jra.issue AS parent
	ON l.related_issue_id = parent.id
	AND parent._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND AND child._fivetran_deleted IS FALSE
	AND child.key = 'MEASURE-3361'