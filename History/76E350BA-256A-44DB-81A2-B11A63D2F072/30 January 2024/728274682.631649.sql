SELECT 
	e.work_start_date,
	e.full_name,
	e.email,
	e.work_title,
	e.work_department,
	CASE 
		WHEN e.work_site = 'United Kingdom, England and Wales' THEN 'UK'
		WHEN e.work_site = 'Australia, Victoria' THEN 'Australia'
		WHEN e.work_site = 'Canada, Ontario' THEN 'Canada'
		ELSE e.work_site
		END AS country,
	MAX(MAX(e._fivetran_synced)) OVER()::TIMESTAMP AS data_up_to
FROM bob.employee AS e
WHERE
	1 = 1
	AND e._fivetran_deleted IS FALSE
	AND e.payroll_employment_type IN ('Permanent', 'Fixed Term (Converting)')
	AND e.internal_status = 'Active'
GROUP BY 1,2,3,4,5