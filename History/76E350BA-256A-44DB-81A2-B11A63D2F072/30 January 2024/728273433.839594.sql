SELECT
	e.payroll_employment_type
FROM bob.employee AS e
WHERE
	1 = 1
	AND e._fivetran_deleted IS FALSE