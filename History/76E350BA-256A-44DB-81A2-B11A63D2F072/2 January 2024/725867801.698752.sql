SELECT
		'Harvest' AS tool,
		LOWER(har_u.email) AS email,
		har_u.id::VARCHAR(256) AS user_id,
		COALESCE(emp.internal_status, 'Unknown') AS bob_status
	FROM harvest.vw_users_latest AS har_u
	LEFT JOIN bob.employee AS emp
		ON LOWER(har_u.email) = LOWER(emp.email)
	WHERE
		1 = 1
		AND har_u._fivetran_deleted IS FALSE
		AND har_u.is_active IS TRUE