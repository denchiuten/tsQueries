SELECT 
	e.full_name,
	e.email,
	CASE 
		WHEN e.work_site = 'United Kingdom, England and Wales' THEN 'United Kingdom'
		WHEN e.work_site = 'Australia, Victoria' THEN 'Australia'
		WHEN e.work_site = 'Canada, Ontario' THEN 'Canada'
		END AS country
FROM bob.employee AS e
WHERE
	1 = 1
	AND e._fivetran_deleted IS FALSE
	AND e.payroll_employment_type IN ('Permanent', 'Fixed Term (Converting)')
	AND e.internal_status = 'Active'