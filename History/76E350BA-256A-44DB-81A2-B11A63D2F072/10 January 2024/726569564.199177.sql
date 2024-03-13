SELECT
	LOWER(b.email) AS requestor_email,
	LOWER(boss.email) AS manager_email,
	l.id AS manager_linear_id
FROM bob.employee AS b
LEFT JOIN bob.employee AS boss
	ON b.work_reports_to_id_in_company = boss.work_employee_id_in_company
	AND boss._fivetran_deleted IS FALSE
LEFT JOIN linear.users AS l
	ON LOWER(boss.email) = LOWER(l.email)
	AND l._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND b._fivetran_deleted IS FALSE
	AND b.email = 'dennis@terrascope.com'