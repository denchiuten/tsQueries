SELECT
	LOWER(n.email) AS email,
	n.id AS notion_user_id,
	l.id AS linear_user_id
FROM notion.users AS n
INNER JOIN linear.users AS l
	ON LOWER(n.email) = LOWER(l.email)
	AND l.active IS TRUE
WHERE
	1 = 1
	AND n._fivetran_deleted IS FALSE
	AND l._fivetran_deleted IS FALSE