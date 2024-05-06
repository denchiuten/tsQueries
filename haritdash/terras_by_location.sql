SELECT 
	e.id,
	e.start_date,
	e.full_name,
	e.email,
	e.title,
	e.department,
	CASE 
		WHEN e.site = 'United Kingdom, England and Wales' THEN 'UK'
		WHEN e.site = 'Australia, Victoria' THEN 'Australia'
		WHEN e.site = 'Canada, Ontario' THEN 'Canada'
		ELSE e.site
		END AS country,
	e._fivetran_synced::TIMESTAMP AS data_up_to
FROM bob.employee AS e
INNER JOIN bob.employee_life_cycle_history AS h
	ON e.id = h.employee_id
	AND h.end_effective_date IS NULL
	AND h.status = 'employed'
WHERE
	1 = 1
	AND e.start_date IS NOT NULL