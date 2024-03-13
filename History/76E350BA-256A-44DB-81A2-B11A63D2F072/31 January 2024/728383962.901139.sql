SELECT
	h.issue_id,
	i.key AS issue_key,
	u.name AS updated_by_name,
	u.email AS updated_by_email,
	b2.full_name AS manager_name,
	b2.email AS manager_email,
	'https://gpventure.atlassian.net/browse/' || i.key AS url,
	MAX(h.time::DATE) AS latest_update
FROM jra.issue_field_history AS h
INNER JOIN jra.issue AS i
	ON h.issue_id = i.id
	AND i._fivetran_deleted IS FALSE
INNER JOIN jra.user AS u
	ON h.author_id = u.id	
	AND u.name <> 'Automation for Jira'
LEFT JOIN bob.employee AS b
	ON LOWER(u.email) = LOWER(b.email)
LEFT JOIN bob.employee AS b2
	ON b.work_reports_to_id_in_company = b2.work_employee_id_in_company
WHERE
	1 = 1
	AND h.time::DATE >= '2024-01-25'
GROUP BY 1,2,3,4,5,6,7
ORDER BY 7 DESC