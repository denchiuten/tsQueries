SELECT 
	e.id,
	e.start_date,
	e.full_name,
	e.email,
	e.title,
	e.department,
	CASE 
		WHEN e.site LIKE 'United Kingdom%' THEN 'UK'
		WHEN e.site LIKE 'Australia%' THEN 'Australia'
		WHEN e.site LIKE 'United States%' THEN 'US'
		WHEN e.site LIKE 'Indonesia%' THEN 'Indonesia'
		WHEN e.site LIKE 'Canada%' THEN 'Canada'
		ELSE e.site
		END AS country,
	e._fivetran_synced::TIMESTAMP AS data_up_to
FROM bob.employee AS e
INNER JOIN bob.employment_history AS h
	ON e.id = h.employee_id
INNER JOIN bob.company AS clv
	ON h.type = clv.id
	AND value IN ('Fixed Term', 'Permanent')
WHERE
	1 = 1
	AND e.start_date IS NOT NULL
	AND e._fivetran_deleted IS FALSE