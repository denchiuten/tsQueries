SELECT
	LOWER(b.email) AS requestor_email,
	LOWER(b.work_reports_to_email) AS manager_email,
	l.id AS manager_linear_id
FROM bob.employee AS b
INNER JOIN linear.users AS l
	ON LOWER(b.work_reports_to_email) = LOWER(l.email)
	AND l._fivetran_deleted IS FALSE
	AND l.active IS TRUE
WHERE
	1 = 1
	AND b._fivetran_deleted IS FALSE
	AND b.email = 'dennis@terrascope.com'