SELECT
		'Hubspot' AS tool,
		LOWER(hub_u.email) AS email,
		hub_u.owner_id AS user_id,
		COALESCE(emp.internal_status, 'Unknown') AS bob_status
	FROM hubs.owner AS hub_u
	LEFT JOIN bob.employee AS emp
		ON LOWER(hub_u.email) = LOWER(emp.email)
	WHERE
		1 = 1
		AND hub_u._fivetran_deleted IS FALSE