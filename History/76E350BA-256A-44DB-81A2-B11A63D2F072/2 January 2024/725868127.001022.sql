SELECT
		'auth0' AS tool,
		LOWER(auth0_u.email) AS email,
		auth0_u.id AS user_id,
		COALESCE(emp.internal_status, 'Unknown') AS bob_status
	FROM auth0.users AS auth0_u
	LEFT JOIN bob.employee AS emp
		ON LOWER(auth0_u.email) = LOWER(emp.email)
	WHERE
		1 = 1
		AND auth0_u._fivetran_deleted IS FALSE