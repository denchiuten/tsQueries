SELECT
	b.full_name,
	b.email	
FROM bob.employee AS b
WHERE
	1 = 1
	AND b._fivetran_deleted IS FALSE
	AND b.payroll_employment_type = 'Agency Contractor'
	AND b.internal_termination_date IS NULL
	AND b.internal_status = 'Active'