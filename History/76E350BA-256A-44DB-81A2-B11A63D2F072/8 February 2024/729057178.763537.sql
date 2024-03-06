SELECT
	e.full_name,
	e.work_start_date
FROM bob.employee AS e
WHERE
	1 = 1
	AND internal_status = 'Active'
ORDER BY 1