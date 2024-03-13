SELECT
		'Quickbooks' AS tool,
		LOWER(qb..email) AS email,
		qb.id AS user_id,
		COALESCE(emp.internal_status, 'Unknown') AS bob_status
	FROM quickbooks.employee AS qb
	LEFT JOIN bob.employee AS emp
		ON LOWER(qb.email) = LOWER(emp.email)
	WHERE
		1 = 1
		AND qb.active IS TRUE
		AND qb._fivetran_deleted IS FALSE
		AND qb.email IS NOT NULL