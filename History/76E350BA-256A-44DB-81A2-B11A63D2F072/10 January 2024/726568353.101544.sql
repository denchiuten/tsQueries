SELECT
	b.email,
	b.work_manager
FROM bob.employee AS b
WHERE
	1 = 1
	AND b._fivetran_deleted IS FALSE
	AND b.email = 'dennis@terrascope.com'