SELECT 
	e.full_name,
	e.email,
	e.work_site
FROM bob.employee AS e
WHERE
	1 = 1
	AND e._fivetran_deleted IS FALSE
	AND e.payroll_employment_type IN ('Permanent', 'Fixed Term (Converting)')
	AND e.internal_status = 'Active'