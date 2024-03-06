SELECT
	n.email,
	b.internal_status
FROM notion.users AS n
LEFT JOIN bob.employee AS b
	ON LOWER(n.email) = LOWER(b.email)
WHERE
	1 = 1
	AND n._fivetran_deleted IS FALSE
ORDER BY 2, 1