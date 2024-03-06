SELECT
	b.email AS requestor_email,
	boss.email AS manager_email
FROM bob.employee AS b
INNER JOIN bob.employee AS boss
	ON b.work_reports_to_id_in_company = boss.id
WHERE
	1 = 1
	AND b._fivetran_deleted IS FALSE
	AND b.email = 'dennis@terrascope.com'