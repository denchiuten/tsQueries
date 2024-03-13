SELECT
	n.email,
	b.internal_status,
	COUNT(p.id) AS n_pages
FROM notion.users AS n
LEFT JOIN bob.employee AS b
	ON LOWER(n.email) = LOWER(b.email)
LEFT JOIN notion.page AS p
	ON n.id = p.last_edited_by
WHERE
	1 = 1
	AND n._fivetran_deleted IS FALSE
	AND n.email IS NOT NULL
GROUP BY 1,2
ORDER BY 2,1